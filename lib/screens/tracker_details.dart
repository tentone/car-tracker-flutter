import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:sqflite/sqflite.dart';

class TrackerDetailsScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerDetailsScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerDetailsScreen> createState() {
    return TrackerDetailsScreenState();
  }
}

class TrackerDetailsScreenState extends State<TrackerDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> detailsForms = [
      TextFormField(
        controller: TextEditingController(text: widget.tracker.adminNumber),
        decoration: InputDecoration(
            icon: const Icon(Icons.contact_phone),
            labelText: Locales.get('adminNumber', context),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIcon: IconButton(
                icon: const Icon(Icons.contact_phone, color: Colors.grey),
                onPressed: () async {
                  final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                  if (contact.phoneNumber?.number != null) {
                    String number = contact.phoneNumber?.number ?? '';
                    setState(() {
                      widget.tracker.adminNumber = number;
                    });
                  }
                })),
        onChanged: (value) => widget.tracker.adminNumber = value,
      ),
      TextFormField(
          enabled: false,
          controller: TextEditingController(text: widget.tracker.id),
          decoration: InputDecoration(
            icon: const Icon(Icons.perm_identity),
            labelText: Locales.get('id', context),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      TextFormField(
          enabled: false,
          controller: TextEditingController(text: widget.tracker.apn),
          decoration: InputDecoration(
            icon: const Icon(Icons.perm_identity),
            labelText: Locales.get('apn', context),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      TextFormField(
          enabled: false,
          controller: TextEditingController(text: widget.tracker.iccid),
          decoration: InputDecoration(
            icon: const Icon(Icons.perm_identity),
            labelText: Locales.get('iccid', context),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      TextFormField(
          enabled: false,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: TextEditingController(text: widget.tracker.speedLimit.toString()),
          decoration: InputDecoration(
            icon: const Icon(Icons.speed),
            labelText: Locales.get('speedLimit', context),
            suffixText: 'miles/h',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      TextFormField(
          enabled: false,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: TextEditingController(text: widget.tracker.sleepLimit.toString()),
          decoration: InputDecoration(
            icon: const Icon(Icons.mode_standby),
            labelText: Locales.get('sleepLimit', context),
            suffixText: 'm',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      TextFormField(
          enabled: false,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: TextEditingController(text: widget.tracker.battery.toString()),
          decoration: InputDecoration(
            icon: const Icon(Icons.battery_full),
            labelText: Locales.get('battery', context),
            suffixText: '%',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          )),
      CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(Locales.get('ignitionAlarm', context)),
          value: widget.tracker.ignitionAlarm,
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: null,
          secondary: const Icon(Icons.alarm)),
      CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(Locales.get('powerAlarmCall', context)),
          value: widget.tracker.powerAlarmCall,
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: null,
          secondary: const Icon(Icons.call)),
      CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(Locales.get('powerAlarmSMS', context)),
          value: widget.tracker.powerAlarmSMS,
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: null,
          secondary: const Icon(Icons.sms_failed))
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(Locales.get('details', context)),
        ),
        body: Form(
          key: formKey,
          child: ListView(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), children: [
            ...detailsForms,
            ElevatedButton(
                child: Text(Locales.get('save', context)),
                onPressed: () async {
                  Database? db = await DataBase.get();
                  await TrackerDB.update(db!, widget.tracker);
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}
