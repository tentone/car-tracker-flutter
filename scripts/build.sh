#!/bin/bash

echo " - Build app bundle"
flutter build appbundle

echo " - Move to app folder"
mv build\app\outputs\bundle\release\app-release.aab app/cartracker.abb

echo " - Done!"