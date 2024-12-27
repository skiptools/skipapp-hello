import SwiftUI

public enum ContentTab: String, Hashable {
    case welcome, home, settings
}

public struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.welcome
    @State var viewModel = ViewModel()
    @State var appearance = ""
    @State var isBeating = false

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            VStack(spacing: 0) {
                Text("Hello [\(viewModel.name)](https://skip.tools)!")
                    .padding()
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .scaleEffect(isBeating ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isBeating)
                    .onAppear { isBeating = true }
            }
            .font(.largeTitle)
            .tabItem { Label("Welcome", systemImage: "heart.fill") }
            .tag(ContentTab.welcome)

            NavigationStack {
                List {
                    ForEach(viewModel.items) { item in
                        NavigationLink(value: item) {
                            Label {
                                Text(item.itemTitle)
                            } icon: {
                                if item.favorite {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                }
                            }
                        }
                    }
                    .onDelete { offsets in
                        viewModel.items.remove(atOffsets: offsets)
                    }
                    .onMove { fromOffsets, toOffset in
                        viewModel.items.move(fromOffsets: fromOffsets, toOffset: toOffset)
                    }
                }
                .navigationTitle(Text("\(viewModel.items.count) Items"))
                .navigationDestination(for: Item.self) { item in
                    ItemView(item: item, viewModel: $viewModel)
                        .navigationTitle(item.itemTitle)
                }
                .toolbar {
                    ToolbarItemGroup {
                        Button {
                            withAnimation {
                                viewModel.items.insert(Item(), at: 0)
                            }
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }
            .tag(ContentTab.home)

            NavigationStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                    Picker("Appearance", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    HStack {
                        #if SKIP
                        ComposeView { ctx in // Mix in Compose code!
                            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                        }
                        #else
                        Text(verbatim: "💙")
                        #endif
                        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                            Text("Version \(version) (\(buildNumber))")
                                .foregroundStyle(.gray)
                        }
                        Text("Powered by [Skip](https://skip.tools)")
                    }
                    .foregroundStyle(.gray)
                }
                .navigationTitle("Settings")
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            .tag(ContentTab.settings)
        }
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

struct ItemView : View {
    @State var item: Item
    @Binding var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            TextField("Title", text: $item.title)
                .textFieldStyle(.roundedBorder)
            Toggle("Favorite", isOn: $item.favorite)
            DatePicker("Date", selection: $item.date)
            Text("Notes").font(.title3)
            TextEditor(text: $item.notes)
                .border(Color.secondary, width: 1.0)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.save(item: item)
                    dismiss()
                }
                .disabled(!viewModel.isUpdated(item))
            }
        }
    }
}
