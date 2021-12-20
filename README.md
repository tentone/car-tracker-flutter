# Car Tracker

- Car Tracker application using Flutter, as a rewrite of [this project](https://github.com/tentone/car-tracker-ion) originally developed using Ionic and Capacitor 
- Track car GPS position for SMS based Chinese tracker(s) marketed under the model number A11, ST-901, GT01 and GT09.



### Getting Started

- Install [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) and get the [Flutter SDK](https://flutter.dev/).

- Ensure that you have the environment variables `GRADLE_HOME`, `JAVA_HOME` and `ANDROID_SDK_ROOT`, and have access to `java` and `gradle` from the your terminal (or command line in windows).

  - `GRADLE_HOME` ...\Gradle\gradle-7.2
  - `JAVA_HOME` ...\Java\jdk1.8.0_301
  - `ANDROID_SDK_ROOT` ...\AppData\Local\Android\Sdk

- Configure your path to ensure that `flutter` is accessible from the terminal

- Run `flutter pub get` in the project root to update dependencies.

- If flutter cannot find the Android SDK please run `flutter config --android-sdk <path>`

  

### Build

- Check the flutter [android](https://flutter.io/docs/deployment/android) and [ios](https://flutter.io/docs/deployment/ios) publish guides for more information.
- The application has only tested in Android during development.
- To build a release APK for android run `flutter build apk` on the project folder.
- Don't forget to update the project version on the `pubspec.yaml` file.
- When building APK output is the `build\app\outputs\apk\release` folder.



### Dependencies
- https://pub.dev/packages/sqlite3
- https://pub.dev/packages/flutter_sms
- https://pub.dev/packages/sms_receiver
- https://githubmemory.com/repo/arsamme/flutter-sms-retriever
- https://pub.dev/packages/mapbox_gl
- https://github.com/therezacuet/Motion-Tab-Bar


### License

- This project is distributed under [MIT license](https://opensource.org/licenses/MIT) and can be used for commercial applications.
- License is available on the Github page of the project.