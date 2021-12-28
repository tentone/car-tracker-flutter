import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/utils/sms_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class TrackerEditScreen extends StatefulWidget {
  const TrackerEditScreen({Key? key}) : super(key: key);

  @override
  State<TrackerEditScreen> createState() {
    return TrackerEditScreenState();
  }
}

class TrackerEditScreenState extends State<TrackerEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Locales.get('editTracker', context)),
      ),
      body: const Center(),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
          if(contact.phoneNumber?.number != null) {
            print(contact.phoneNumber?.number);
          }

          SMSUtils.send('g1234', '+351915939715');
        },
        child: const Icon(Icons.sms),
      ),
    );

  }
}