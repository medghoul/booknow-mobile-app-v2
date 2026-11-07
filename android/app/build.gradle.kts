plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.booknow"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.booknow"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // AppAuth's redirect activity is registered against this scheme; it
        // must match COGNITO_REDIRECT_URI and the pool's CallbackURLs.
        manifestPlaceholders["appAuthRedirectScheme"] = "booknow"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "default"
    productFlavors {
        create("local") {
            dimension = "default"
            applicationIdSuffix = ".local"
            versionNameSuffix = "-local"
            resValue(type = "string", name = "app_name", value = "BookNow Local")
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".development"
            versionNameSuffix = "-dev"
            resValue(type = "string", name = "app_name", value = "BookNow Dev")
        }
        create("production") {
            dimension = "default"
            applicationIdSuffix = ".production"
            resValue(type = "string", name = "app_name", value = "BookNow")
        }
    }    
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
