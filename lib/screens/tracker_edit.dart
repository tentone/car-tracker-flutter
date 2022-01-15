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
              decoration: InputDecoration(
                icon: const Icon(Icons.drive_file_rename_outline),
                labelText: Locales.get('name', context),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              onChanged: (value) => widget.tracker.name = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.licensePlate),
              decoration: InputDecoration(
                icon: const Icon(Icons.document_scanner),
                labelText: Locales.get('licensePlate', context),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              onChanged: (value) => widget.tracker.licensePlate = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.chassisNumber),
              decoration: InputDecoration(
                icon: const Icon(Icons.car_rental),
                labelText: Locales.get('chassisNumber', context),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              onChanged: (value) => widget.tracker.chassisNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.model),
              decoration: InputDecoration(
                icon: const Icon(Icons.car_repair),
                labelText: Locales.get('model', context),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              onChanged: (value) => widget.tracker.model = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.phoneNumber),
              decoration: InputDecoration(
                  icon: const Icon(Icons.phone),
                  labelText: Locales.get('phoneNumber', context),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  suffixIcon: FloatingActionButton(
                      child: const Icon(Icons.contact_phone, color: Colors.grey),
                      backgroundColor: Colors.transparent,
                      onPressed: () async {
                        final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                        if(contact.phoneNumber?.number != null) {
                          String number = contact.phoneNumber?.number ?? '';
                          setState(() {
                            widget.tracker.phoneNumber = number;
                          });
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
                  labelText: Locales.get('adminNumber', context),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  suffixIcon: FloatingActionButton(
                    child: const Icon(Icons.contact_phone, color: Colors.grey),
                    backgroundColor: Colors.transparent,
                    onPressed: () async {
                      final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                      if(contact.phoneNumber?.number != null) {
                        String number = contact.phoneNumber?.number ?? '';
                        setState(() {
                          widget.tracker.adminNumber = number;
                        });
                      }
                    }
                  )

              ),
              onChanged: (value) => widget.tracker.adminNumber = value,
            ),
            TextFormField(
              controller: TextEditingController(text: widget.tracker.pin),
              obscureText: true,
              decoration: InputDecoration(
                icon: const Icon(Icons.password),
                labelText: Locales.get('pin', context),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
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
      floatingActionButton: widget.tracker.phoneNumber.isEmpty ? const SizedBox() : FloatingActionButton(
        onPressed: () async {
          SMSUtils.send('g1234', widget.tracker.phoneNumber);
          Modal.toast(context, Locales.get('requestedPosition', context));
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );

  }
}