import SwiftUI

public struct ContentView: View {
    @AppStorage("setting") var setting = true

    public init() {
    }

    public var body: some View {
        TabView {
            VStack {
                Text("Welcome Skipper!")
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
            .font(.largeTitle)
            .tabItem { Label("Welcome", systemImage: "heart.fill") }

            NavigationStack {
                List {
                    ForEach(1..<1_000) { i in
                        NavigationLink("Home \(i)", value: i)
                    }
                }
                .navigationTitle("Navigation")
                .navigationDestination(for: Int.self) { i in
                    Text("Destination \(i)")
                        .font(.title)
                        .navigationTitle("Navigation \(i)")
                }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack {
                Form {
                    Toggle("Option", isOn: $setting)
                    #if SKIP
                    ComposeView { ctx in
                        androidx.compose.material3.Text("Powered by Jetpack Compose", modifier: ctx.modifier, color: Color.gray.colorImpl())
                    }
                    #else
                    Text("Powered by SwiftUI")
                        .foregroundStyle(.gray)
                    #endif
                }
                .navigationTitle("Settings")
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
    }
}

#Preview {
    ContentView()
}
