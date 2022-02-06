#!/bin/bash

cd ..

echo " - Formatting dart code"
flutter format -l 200 --fix .

echo " - Done!"