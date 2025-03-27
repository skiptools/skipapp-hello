
plugins {
    `kotlin-dsl`
    `java-gradle-plugin`
}

repositories {
    google()
    mavenCentral()
}

gradlePlugin {
    plugins {
        create("skip-plugin") {
            id = "skip-plugin"
            implementationClass = "SkipSettingsPlugin"
        }
        create("skip-build-plugin") {
            id = "skip-build-plugin"
            implementationClass = "SkipBuildPlugin"
        }
    }
}

dependencies {
    compileOnly("com.android.tools.build:gradle:8.5.0")
}
