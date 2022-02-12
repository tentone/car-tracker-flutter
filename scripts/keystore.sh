#!/bin/bash

keytool -genkey -v -keystore ./keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload