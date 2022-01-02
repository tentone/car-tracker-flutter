import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/utils/sms_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class TrackerEditScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerEditScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerEditScreen> createState() {
    return TrackerEditScreenState();
  }
}

class TrackerEditScreenState extends State<TrackerEditScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // widget.tracker

    return Scaffold(
      appBar: AppBar(
          title: Text(Locales.get('editTracker', context)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: const <Widget>[
            // TODO <ADD CODE HERE>
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