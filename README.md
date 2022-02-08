# Car Tracker Flutter

- Car Tracker application using Flutter, as a rewrite of [this project](https://github.com/tentone/car-tracker-ion) originally developed using Ionic and Capacitor 

- Mobile application to track car GPS position for SMS-based Chinese tracker(s) marketed under the model number A11, ST-901, GT01, and GT09.

 - Manage multiple GPS car trackers using SMS communication.

 - Set multiple parameters of the tracker (e.g. speed limit, sleep time, password, distance alarm)

 - Manage and list messages exchanged with the car tracker.

- Track car GPS position for SMS-based Chinese tracker(s) marketed under the model number A11, ST-901, GT01 and GT09.

[<img src="https://raw.githubusercontent.com/tentone/car-tracker-flutter/master/store/badge.png" width="200">](https://play.google.com/store/apps/details?id=com.tentone.cartarcker.cartracker)

<img src="https://raw.githubusercontent.com/tentone/car-tracker-ionic/master/readme/front.jpg" width="250"><img src="https://raw.githubusercontent.com/tentone/car-tracker-ionic/master/readme/back.jpg" width="250"><img src="https://raw.githubusercontent.com/tentone/car-tracker-ionic/master/readme/pcb.jpg" width="250">

### Screenshots

<img src="https://raw.githubusercontent.com/tentone/car-tracker-flutter/master/store/screenshot/map.png" width="250"><img src="https://raw.githubusercontent.com/tentone/car-tracker-flutter/master/store/screenshot/history.png" width="250"><img src="https://raw.githubusercontent.com/tentone/car-tracker-flutter/master/store/screenshot/list.png" width="250">

### Getting Started

- Install [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) and get the [Flutter SDK](https://flutter.dev/).

- Ensure that you have the environment variables `GRADLE_HOME`, `JAVA_HOME` and `ANDROID_SDK_ROOT`, and have access to `java` and `gradle` from the your terminal (or command line in windows).

  - `GRADLE_HOME` ...\Gradle\gradle-7.2
  - `JAVA_HOME` ...\Java\jdk1.8.0_301
  - `ANDROID_SDK_ROOT` ...\AppData\Local\Android\Sdk

- Configure your path to ensure that `flutter` is accessible from the terminal

- Run `flutter pub get` in the project root to update dependencies.

- If flutter cannot find the Android SDK please run `flutter config --android-sdk <path>`

- Use `flutter doctor` to debug setup problems. Don't forget to accept the `flutter doctor --android-licenses`.

### SDF Icons
 - Mapbox uses SDF-based icons, to generate icons use the tool [image-sdf](https://github.com/mattdesl/image-sdf) or [sdfgen](https://github.com/ConnyOnny/sdfgen) from the command line.
 - SDF allow for high quality rendering of 2D shapes and should be used when possible.
```bash
npm install -g image-sdf
image-sdf .\car-marker.png -s 6 -d 8 -c "#fff" -o car-sdf.png
```

### Build

- Check the flutter [android](https://flutter.io/docs/deployment/android) and [ios](https://flutter.io/docs/deployment/ios) publish guides for more information.
- The application has only tested in Android during development.
- To build a release APK for android run `flutter build apk` on the project folder.
- For publishing a ABB file is preferred run `flutter build appbundle`
- Don't forget to update the project version on the `pubspec.yaml` file.
- When building APK output is the `build\app\outputs\apk\release` folder.

### Android Permissions

- When new plugins are added to provide additional native functionality, the permissions list in the `AndroidManifest.xml` should be updated.
- It might be necessary to also request for permission during runtime before using the feature.

```xml
<!-- Geolocation -->
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<!-- File API-->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- Contacts -->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS"/>

<!-- SMS -->
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.READ_SMS" />
<queries>
<intent>
  <action android:name="android.intent.action.SENDTO" />
  <data android:scheme="smsto"/>
</intent>
</queries>
```

### License

- This project is distributed under [MIT license](https://opensource.org/licenses/MIT) and can be used for commercial applications.
- License is available on the Github page of the project.