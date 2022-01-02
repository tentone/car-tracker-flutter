import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/utils/sms_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:sqflite/sqflite.dart';

class TrackerEditScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerEditScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerEditScreen> createState() {
    return TrackerEditScreenState();
  }
}

class TrackerEditScreenState extends State<TrackerEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // widget.tracker

    return Scaffold(
      appBar: AppBar(
          title: Text(Locales.get('editTracker', context)),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: Locales.get('name', context)),
              onChanged: (value) => widget.tracker.name = value,
            ),
            TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: Locales.get('licensePlate', context)),
              onChanged: (value) => widget.tracker.licensePlate = value,
            ),
            TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: Locales.get('chassisNumber', context)),
              onChanged: (value) => widget.tracker.chassisNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: Locales.get('model', context)),
              onChanged: (value) => widget.tracker.model = value,
            ),
            ColorPicker(
              pickerColor: Colors.blue,
              onColorChanged: (value) => widget.tracker.color = value.toString(),
            ),
            ElevatedButton(
              child: Text(Locales.get('update', context)),
              onPressed: () async {
                Database? db = await DataBase.get();
                await TrackerDB.update(db!, widget.tracker);
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SMSUtils.listen();

          await SMSUtils.getAll();

          // SMSUtils.send('g1234', '915939715');

          final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
          if(contact.phoneNumber?.number != null) {
            String number = contact.phoneNumber?.number ?? '';
            SMSUtils.send('g1234', number);

          }
        },
        child: const Icon(Icons.sms),
      ),
    );

  }
}