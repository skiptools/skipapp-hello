import Foundation
import OSLog
import SwiftUI

/// A logger for the HelloSkip module.
let logger: Logger = Logger(subsystem: "skip.hello.App", category: "HelloSkip")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
public struct HelloSkipRootView : View {
    public init() {
    }

    public var body: some View {
        ContentView()
            .task {
                logger.info("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

/// Global application delegate functions.
///
/// These functions can update a shared observable object to communicate app state changes to interested views.
public final class HelloSkipAppDelegate : Sendable {
    public static let shared = HelloSkipAppDelegate()

    private init() {
    }

    public func onStart() {
        logger.debug("onStart")
    }

    public func onResume() {
        logger.debug("onResume")
    }

    public func onPause() {
        logger.debug("onPause")
    }

    public func onStop() {
        logger.debug("onStop")
    }

    public func onDestroy() {
        logger.debug("onDestroy")
    }

    public func onLowMemory() {
        logger.debug("onLowMemory")
    }
}
