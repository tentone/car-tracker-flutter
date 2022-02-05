#!/bin/bash

cd ..

echo " - Formatting dart code"
flutter format -l 10000 --fix .

echo " - Done!"