import 'dart:ui';

import 'package:flutter/material.dart';

/// Tracker represents a GPS tracker, contains all the metadata required to communicate with the tracker.
class Tracker {
  /// UUID used to identify the tracker.
  String uuid = '';

  /// Name of the tracker.
  String name = '';

  /// License plate of the vehicle where the tracker is placed
  String licensePlate = '';

  /// Chassis number of the vehicle  where the tracker is placed
  String chassisNumber = '';

  /// Model of the tracker.
  String model = '';

  /// Color to represent the tracker on the map.
  Color color = Colors.blue;

  /// Phone number of the tracker used to send and receive messages.
  String phoneNumber = '';

  /// Admin number of the tracker.
  String adminNumber = '';

  /// SOS numbers associated with the tracker (up to 3 SOS numbers).
  List<String> sosNumbers = [];

  /// PIN number of the tracker used for authentication.
  ///
  /// Usually it is a 4 digit numeric pin.
  String pin = '123456';

  /// Limit speed in miles per hour, defined on the tracker.
  int speedLimit = 0;

  /// Time limit before the tracker enters into sleep mode.
  int sleepLimit = 0;

  /// If enabled the ignition alarm is fired every time the ACC signal changes.
  ///
  /// If the signal is not connected to the car it will not fire.
  bool ignitionAlarm = false;

  /// Messages exchanged with the tracker device.
  List<String> messages = [];

  /// Indicates if the alarm sends an SMS to the admin it power was unplugged.
  bool powerAlarmSMS = false;

  /// Indicates if the alarm calls the admin it power was unplugged.
  bool powerAlarmCall = false;

  /// Level of battery of the tracker, has to be read manually using the info command.
  ///
  /// Value from 1 to 5, 5 meaning fully charged.
  int battery = 0;

  /// Access Point Name (APN) configured on the tracker for GPRS data access.
  String apn = '';

  /// Integrated Circuit Card Identifier (ICCID) of the SIM card inserted in the tracker.
  String iccid = '';

  /// ID of the tracker device, each tracker has its own ID.
  String id = '';
}