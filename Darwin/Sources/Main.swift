import SwiftUI
import HelloSkip

/// The entry point to the app simply loads the App implementation from SPM module.
@main struct AppMain: App {
    #if canImport(UIKit)
    @UIApplicationDelegateAdaptor(AppMainDelete.self) var appDelegate
    #endif
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            HelloSkipRootView()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                HelloSkipAppDelegate.shared.onResume(appDelegate.application!)
            case .inactive:
                HelloSkipAppDelegate.shared.onPause(appDelegate.application!)
            case .background:
                HelloSkipAppDelegate.shared.onStop(appDelegate.application!)
            @unknown default:
                print("unknown app phase: \(newPhase)")
            }
        }
    }
}

#if canImport(UIKit)
class AppMainDelete: UIResponder, UIApplicationDelegate {
    unowned var application: UIApplication? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        self.application = application
        HelloSkipAppDelegate.shared.onStart(application)
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        HelloSkipAppDelegate.shared.onDestroy(application)
    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        HelloSkipAppDelegate.shared.onLowMemory(application)
    }
}
#endif
