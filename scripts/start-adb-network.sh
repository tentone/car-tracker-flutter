#!/bin/bash

ADDRESS="192.168.0.254"

echo " - Start ADB server"
adb tcpip 5555

echo " - Connect to address $ADDRESS"
adb connect $ADDRESS

echo " - Done!"