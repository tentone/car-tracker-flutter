#!/bin/bash

cd ..

echo " - Formatting dart code"
dart format --fix .

echo " - Done!"