import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val dartDefines = (project.findProperty("dart-defines") as String?)
    .orEmpty()
    .split(',')
    .mapNotNull { encodedDefine ->
        if (encodedDefine.isBlank()) {
            return@mapNotNull null
        }

        val decodedDefine = runCatching {
            String(Base64.getDecoder().decode(encodedDefine))
        }.getOrNull() ?: return@mapNotNull null
        val separatorIndex = decodedDefine.indexOf('=')

        if (separatorIndex <= 0) {
            return@mapNotNull null
        }

        decodedDefine.substring(0, separatorIndex) to
            decodedDefine.substring(separatorIndex + 1)
    }
    .toMap()

val isPortfolioBuild = dartDefines["PORTFOLIO_MODE"]
    ?.equals("true", ignoreCase = true) == true

android {
    namespace = "id.go.bandungkab.rsudotista.mobile"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = if (isPortfolioBuild) {
            "id.go.bandungkab.rsudotista.mobile.portfolio"
        } else {
            "id.go.bandungkab.rsudotista.mobile"
        }
        manifestPlaceholders["appLabel"] = if (isPortfolioBuild) {
            "Portal Pasien Demo"
        } else {
            "RSUD Otista Mobile"
        }
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    sourceSets {
        getByName("debug") {
            manifest.srcFile(
                if (isPortfolioBuild) {
                    "src/portfolio/AndroidManifest.xml"
                } else {
                    "src/debug/AndroidManifest.xml"
                },
            )
        }
        getByName("profile") {
            manifest.srcFile(
                if (isPortfolioBuild) {
                    "src/portfolio/AndroidManifest.xml"
                } else {
                    "src/profile/AndroidManifest.xml"
                },
            )
        }
    }
}

flutter {
    source = "../.."
}
