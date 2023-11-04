
HelloSkip is the canonical sample Skip app that that is created
with the commands:

```shell
brew install skiptools/skip/skip
skip init --appid=skip.hello.App --version 1.0.0 hello-skip HelloSkip
```

The repository is both a valid Swift Package Manager project,
as well as an Xcode project. Running the "HelloSkipApp" target
in Xcode will compile and run the app on an iOS simulator,
as well as transpile the app into a Kotlin Gradle project,
comple the app, and run it on an Android emulator (which must first
be launched from Android Studio).

For layout of the project is as follows:

```
hello-skip
├── HelloSkip.xcconfig
├── HelloSkip.xcodeproj
│   └── project.pbxproj
├── Package.resolved
├── Package.swift
├── README.md
├── Sources
│   ├── HelloSkip
│   │   ├── ContentView.swift
│   │   ├── HelloSkip.swift
│   │   ├── HelloSkipApp.swift
│   │   ├── Resources
│   │   │   └── Localizable.xcstrings
│   │   └── Skip
│   │       ├── AndroidManifest.xml
│   │       ├── Assets.xcassets
│   │       │   ├── AccentColor.colorset
│   │       │   │   └── Contents.json
│   │       │   ├── AppIcon.appiconset
│   │       │   │   └── Contents.json
│   │       │   └── Contents.json
│   │       ├── Capabilities.entitlements
│   │       └── skip.yml
│   └── HelloSkipApp
│       └── HelloSkipAppMain.swift
└── Tests
    └── HelloSkipTests
        ├── HelloSkipTests.swift
        ├── Resources
        │   └── TestData.json
        ├── Skip
        │   └── skip.yml
        └── XCSkipTests.swift
```


## Building

This project is both a stand-alone Swift Package Manager module,
as well as an Xcode project that builds and transpiles the project
into a Kotlin Gradle project for Android using the Skip plugin.

Building the module requires that Skip be installed using
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.

This will also install the necessary transpiler prerequisites:
Kotlin, Gradle, and the Android build tools.

Installation requirements can be confirmed by running `skip checkup`.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS desintation in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.

## Running

Xcode and Android Studio must be downloaded and installed in order to
run the app in the iOS simulator / Android emulator.
An Android emulator must already be running, which can be launched from 
Android Stuido's Device Manager.

To run both the Swift and Kotlin apps simultaneously, 
launch the HelloSkipApp target from Xcode.
A build phases runs the "Launch Android APK" script that
will deploy the transpiled app a running Android emulator or connected device.
Logging output for the iOS app can be viewed in the Xcode console, and in
Android Studio's logcat tab for the transpiled Kotlin app.
