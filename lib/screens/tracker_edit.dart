import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/utils/sms_utils.dart';
import 'package:cartracker/widget/modal.dart';
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
              controller: TextEditingController(text: widget.tracker.name),
              decoration: InputDecoration(icon: const Icon(Icons.drive_file_rename_outline), hintText: Locales.get('name', context)),
              onChanged: (value) => widget.tracker.name = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.licensePlate),
              decoration: InputDecoration(icon: const Icon(Icons.document_scanner), hintText: Locales.get('licensePlate', context)),
              onChanged: (value) => widget.tracker.licensePlate = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.chassisNumber),
              decoration: InputDecoration(icon: const Icon(Icons.car_rental), hintText: Locales.get('chassisNumber', context)),
              onChanged: (value) => widget.tracker.chassisNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.model),
              decoration: InputDecoration(icon: const Icon(Icons.car_repair), hintText: Locales.get('model', context)),
              onChanged: (value) => widget.tracker.model = value,
            ),
            // ColorPicker(
            //   pickerColor: Colors.blue,
            //   onColorChanged: (value) => widget.tracker.color = value.toString(),
            // ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.phoneNumber),
              decoration: InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: Locales.get('phoneNumber', context),
                  suffixIcon: FloatingActionButton(
                      child: const Icon(Icons.contact_phone, color: Colors.grey),
                      backgroundColor: Colors.transparent,
                      onPressed: () async {
                        final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                        if(contact.phoneNumber?.number != null) {
                          String number = contact.phoneNumber?.number ?? '';
                          widget.tracker.phoneNumber = number;
                        }
                      }
                  )

              ),
              onChanged: (value) => widget.tracker.phoneNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.adminNumber),
              decoration: InputDecoration(
                  icon: const Icon(Icons.contact_phone),
                  hintText: Locales.get('adminNumber', context),
                  suffixIcon: FloatingActionButton(
                    child: const Icon(Icons.contact_phone, color: Colors.grey),
                    backgroundColor: Colors.transparent,
                    onPressed: () async {
                      final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                      if(contact.phoneNumber?.number != null) {
                        String number = contact.phoneNumber?.number ?? '';
                        widget.tracker.adminNumber = number;
                      }
                    }
                  )

              ),
              onChanged: (value) => widget.tracker.adminNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.pin),
              obscureText: true,
              decoration: InputDecoration(icon: const Icon(Icons.password), hintText: Locales.get('pin', context)),
              onChanged: (value) => widget.tracker.pin = value,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: Color(widget.tracker.color),
                          onColorChanged: (value) {
                            setState(() {
                              widget.tracker.color = value.value;
                            });
                          }
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(Locales.get('color', context)),
              style: ElevatedButton.styleFrom(
                primary: Color(widget.tracker.color),
                elevation: 10,
              ),
            ),
            ElevatedButton(
              child: Text(Locales.get('save', context)),
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