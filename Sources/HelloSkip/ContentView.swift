import SwiftUI

public struct ContentView: View {
    @State var mode = false
    @AppStorage("tab") var tab = Tab.welcome
    @AppStorage("name") var name = "Skipper"

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            VStack {
                Text("Hello \(name)!")
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
            .font(.largeTitle)
            .tabItem { Label("Welcome", systemImage: "heart.fill") }
            .tag(Tab.welcome)

            NavigationStack {
                List {
                    ForEach(1..<1_000) { i in
                        NavigationLink("Item \(i)", value: i)
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for: Int.self) { i in
                    Text("Item \(i)")
                        .font(.title)
                        .navigationTitle("Screen \(i)")
                }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }
            .tag(Tab.home)

            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                    Toggle("Mode", isOn: $mode).onChange(of: mode) { _ in
                        logger.log("Toggled mode to: \(mode)")
                    }
                    HStack {
                        #if SKIP
                        ComposeView { ctx in
                            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                        }
                        #else
                        Text(verbatim: "💙")
                        #endif
                        Text("Powered by \(androidSDK != nil ? "Jetpack Compose" : "SwiftUI")")
                    }
                    .foregroundStyle(.gray)
                    .bold(mode)
                }
                .navigationTitle("Settings")
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            .tag(Tab.settings)
        }
    }
}

enum Tab : String, Hashable {
    case welcome, home, settings
}

#Preview {
    ContentView()
}
