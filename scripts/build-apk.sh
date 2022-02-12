#!/bin/bash

cd ..

echo " - Build APK for app"
flutter build apk

echo " - Move to app folder"
mv build/app/outputs/flutter-apk/app-release.apk app/cartracker.apk

echo " - Done!"