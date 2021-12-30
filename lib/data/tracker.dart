import 'dart:ui';

import 'package:cartracker/utils/sms_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Tracker represents a GPS tracker, contains all the metadata required to communicate with the tracker.
class Tracker {
  /// UUID used to identify the tracker.
  String uuid = '';

  /// ID of the tracker device, each tracker has its own ID.
  String id = '';

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

  /// Messages exchanged with the tracker device.
  List<String> messages = [];

  Tracker() {
    this.uuid = const Uuid().v4().toString();
  }

  /// Process a message received from SMS and store its result on a tracker message.
  ///
  /// @param message Message received.
  void processSMS(String message) {


    // Acknowledge message
    String ackMsg = message.toLowerCase();
    if (ackMsg == 'admin ok' || ackMsg == 'apn ok' || ackMsg == 'password ok' || ackMsg == 'speed ok' || ackMsg == 'ok') {
      // msg.type = MessageType.ACKNOWLEDGE;
      //
      // Modal.toast(Locale.get('trackerAcknowledge', {name: this.name}));
      // this.addMessage(msg);

      return;
    }

    // List of SOS numbers
    // if (message.startsWith('101#')) {
    //   msg.type = MessageType.SOS_NUMBERS;
    //
    //   let numbers = message.split(' ');
    //   for (let i = 0; i < numbers.length;  i++) {
    //   this.sosNumbers[i] = numbers[i].substr(4);
    //   }
    //
    //   // Modal.toast(Locale.get('trackerAcknowledge', {name: this.name}));
    //   this.addMessage(msg);
    //   return;
    // }

    // GPS Location
    if (message.startsWith('http')) {
      try {
        const regex = /https?\:\/\/maps\.google\.cn\/maps\??q?=?N?([\-0-9\.]*),?W?([\-0-9\.]*)\s*ID:([0-9]+)\s*ACC:([A-Z]+)\s*GPS:([A-Z]+)\s*Speed:([0-9\.]+) ?KM\/H\s*([0-9]+)\-([0-9]+)\-([0-9]+)\s*([0-9]+):([0-9]+):([0-9]+)/;
        let matches = message.match(regex);
        let data = new LocationData();

        if (matches[1].length > 0) {
          data.position = new Geoposition(Number.parseFloat(matches[1]), -Number.parseFloat(matches[2]));
        }

        data.id = matches[3];
        data.acc = matches[4] != 'OFF';
        data.gps = matches[5] == 'A';
        data.speed = Number.parseFloat(matches[6]);

        int year = Number.parseInt(matches[7], 10) + 2000;
        int month = Number.parseInt(matches[8], 10);
        int day = Number.parseInt(matches[9], 10);
        data.date.setFullYear(year, month, day);

        int hour = Number.parseInt(matches[10], 10);
        int minute = Number.parseInt(matches[11], 10);
        int seconds = Number.parseInt(matches[12], 10);
        data.date.setHours(hour, minute, seconds);
        msg.data = data;
        msg.type = MessageType.LOCATION;

        this.id = data.id;
        // Modal.toast(Locale.get('trackerLocation', {name: this.name}));

        this.addMessage(msg);
        return;
      } catch(e) {
        Modal.alert(Locale.get('error'), Locale.get('errorParseLocationMsg'));
        console.log('CarTracker: Error parsing location message.', e, this);
        this.addMessage(msg);
        return;
      }
    }

    // GPS Tracker data
    const infoRegex = /([A-Za-z0-9_\.]+) ([0-9]+)\/([0-9]+)\/([0-9]+)\s*ID:([0-9]+)\s*IP:([0-9\.a-zA-Z\\]+)\s*([0-9]+) BAT:([0-9])\s*APN:([0-9\.a-zA-Z\\]+)\s*GPS:([0-9A-Z\-]+)\s*GSM:([0-9]+)\s*ICCID:([0-9A-Z]+)/;
    try {
      if (message.search(infoRegex) != -1) {
        let matches = message.match(infoRegex);

        let data = new InformationData();
        data.model = matches[1];
        data.id = matches[5];
        data.ip = matches[6];
        data.port = matches[7];
        data.battery = Number.parseInt(matches[8], 10);
        data.apn = matches[9];
        data.gps = matches[10];
        data.gsm = matches[11];
        data.iccid = matches[12];
        msg.data = data;
        msg.type = MessageType.INFORMATION;

        this.battery = data.battery;
        this.model = data.model;
        this.apn = data.apn;
        this.iccid = data.iccid;
        this.id = data.id;

        // Modal.toast(Locale.get('trackerUpdated', {name: this.name}));
        this.addMessage(msg);
        return;
      }
    }
    catch(e) {
      Modal.alert(Locale.get('error'), Locale.get('errorParseInfoMsg'));
      console.log('CarTracker: Error parsing device info message.', e, this);
      this.addMessage(msg);
      return;
    }

    // Modal.toast(Locale.get('receivedUnknown', {name: this.name}));
    this.addMessage(msg);
  }


  /// Send a message to this tracker, store it in the messages list.
  ///
  /// @param message Message to be sent to the tracker.
  void sendSMS(String message) {
    SMSUtils.send(message, this.phoneNumber);
    this.messages.add(message);
  }

  /// Add message to the list of messages
  void addMessage(String msg) {
    this.messages.add(msg);
  }

  /// Update the tracker in database.
  void storeDB() {
    // TODO <ADD CODE HERE>
  }

  /// Request a data with the location of the device, status and speed of the tracker.
  void getLocation() {
    this.sendSMS('g1234');
  }

  /// Change the timezone of tracker.
  ///
  /// @param timezone Timezone to be used by the tracker.
  void setTimezone(String timezone) {
    String msg = 'zone' + this.pin + ' ' + timezone;

    this.sendSMS(msg);
  }

  /// Request a data with the location of the device, status and speed of the tracker.
  void getTrackerInfo() {
    String msg = 'CXZT';

    this.sendSMS(msg);
  }


  /// Change the pin of the tracker.
  ///
  /// @param newPin New pin to be set on the tracker.
  void changePIN(String newPin) {
    String msg = 'password' + this.pin + ' ' + newPin;

    this.pin = newPin;
    this.storeDB();

    this.sendSMS(msg);
  }


  /// Set admin number used for the admin related information.
  ///
  /// @param phoneNumber Phone number use for control.
  void setAdminNumber(String phoneNumber) {
    String msg = 'admin' + this.pin + ' ' + phoneNumber;

    this.adminNumber = phoneNumber;
    this.sendSMS(msg);
  }


  /// Set sos number used for the GPS to return requested information, alarm messages etc.
  ///
  /// @param phoneNumber Phone number use for control.
  /// @param slot Slot being set can be 1, 2 or 3.
  void setSOSNumber(String phoneNumber, int slot) {
    if (slot < 1 || slot > 3) {
      throw new Exception('Invalid slot value.');
    }

    String msg = '10' + slot.toString() + '#' + phoneNumber + '#';

    this.sosNumbers[slot - 1] = phoneNumber;
    this.sendSMS(msg);
  }

  /// Delete SOS number used for the GPS to return requested information, alarm messages etc.
  ///
  /// @param slot Slot being set can be 1, 2 or 3.
  void deleteSOSNumber(int slot) {
    if (slot < 1 || slot > 3) {
      throw new Exception('Invalid slot value.');
    }

    String msg = 'D10' + slot.toString() + '#';

    this.sosNumbers[slot - 1] = '';
    this.sendSMS(msg);
  }


  /// Request a list of the SOS numbers registered on the device.
  void listSOSNumbers() {
    String msg = 'C10#';

    this.sendSMS(msg);
  }


  /// Enable/disable ignition auto security, used for the tracker to send and SMS every time the car ignition is switched.
  ///
  /// @param enabled State of the ignition alarm.
  void setIgnitionAlarm(bool enabled) {
    String msg = 'accclock,' + this.pin + ',' + (enabled ? '1' : '0');

    this.ignitionAlarm = enabled;
    this.sendSMS(msg);
  }


  /// Configure the tracker to call the admin phone if the power is disconnected from the device.
  ///
  /// @param enabled State of the power alarm.
  void setPowerAlarmCall(bool enabled) {
    String msg = 'pwrcall,' + this.pin + ',' + (enabled ? '1' : '0');

    this.powerAlarmCall = enabled;
    this.sendSMS(msg);
  }


  /// Configure the tracker to send a SMS alarm if the power is disconnected from the device.
  ///
  /// @param enabled State of the power alarm.
  void setPowerAlarmSMS(bool enabled) {
    String msg = 'pwrsms,' + this.pin + ',' + (enabled ? '1' : '0');

    this.powerAlarmSMS = enabled;
    this.sendSMS(msg);
  }


  /// Set the speed limit of the GPS tracker before an alarm is triggered.
  ///
  /// @param speed Speed limit in MPH zero means no speed limit.

  void setSpeedLimit(int speed) {
    if (speed > 999) {
      speed = 999;
    }

    // Round speed value
    speed = speed.round();

    // Covert into 3 digit string
    String strSpeed = speed.toString();
    while (strSpeed.length < 3) {
      strSpeed = '0' + strSpeed;
    }

    String msg = 'speed' + this.pin + ' ' + strSpeed;

    this.speedLimit = speed;
    this.sendSMS(msg);
  }


  /// Set the time of the GPS before it enters sleep mode after being used (wakes up by movement or sms).
  ///
  /// @param time Time limit in minutes, if set to zero it will disable sleep.
  void setSleepTime(int time) {
    String msg = 'sleep,' + this.pin + ',' + time.toString();

    this.sleepLimit = time;
    this.sendSMS(msg);
  }
}