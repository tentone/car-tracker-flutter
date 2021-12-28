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
          SMSUtils.listen();

          // await SMSUtils.getAll('');
          SMSUtils.send('g1234', '915939715');

          // final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
          // if(contact.phoneNumber?.number != null) {
          //   String number = contact.phoneNumber?.number ?? '';
          //   SMSUtils.send('g1234', number);
          //
          // }
        },
        child: const Icon(Icons.sms),
      ),
    );

  }
}