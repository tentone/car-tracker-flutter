import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/screens/tracker_details.dart';
import 'package:cartracker/screens/tracker_message_list.dart';
import 'package:cartracker/screens/tracker_positions_list.dart';
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
    Drawer drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                  child: Text(
                Locales.get('tracker', context),
                style: const TextStyle(
                  fontSize: 24,
                ),
              ))),
          ListTile(
            enabled: widget.tracker.phoneNumber.isNotEmpty,
            leading: const Icon(Icons.speed),
            title: Text(Locales.get('speedLimit', context)),
            onTap: () async {
              int speed = 0;

              // TODO <ADD CODE HERE>

              widget.tracker.setSpeedLimit(speed);
              Database? db = await DataBase.get();
              await TrackerDB.update(db!, widget.tracker);
            },
          ),
          ListTile(
            enabled: widget.tracker.phoneNumber.isNotEmpty,
            leading: const Icon(Icons.call),
            title: Text(Locales.get('powerAlarmCall', context)),
            onTap: () async {
              bool enabled = false;

              // TODO <ADD CODE HERE>

              widget.tracker.setPowerAlarmCall(enabled);
              Database? db = await DataBase.get();
              await TrackerDB.update(db!, widget.tracker);
            },
          ),
          ListTile(
            enabled: widget.tracker.phoneNumber.isNotEmpty,
            leading: const Icon(Icons.sms_outlined),
            title: Text(Locales.get('powerAlarmSMS', context)),
            onTap: () async {
              bool enabled = false;

              // TODO <ADD CODE HERE>

              widget.tracker.setPowerAlarmSMS(enabled);
              Database? db = await DataBase.get();
              await TrackerDB.update(db!, widget.tracker);
            },
          ),
          ListTile(
            enabled: widget.tracker.phoneNumber.isNotEmpty,
            leading: const Icon(Icons.mode_standby),
            title: Text(Locales.get('sleepTime', context)),
            onTap: () async {
              int time = 0;

              // TODO <ADD CODE HERE>
              // Modal.question(context, Locales.get('sleepTime', context), message, options)

              widget.tracker.setSleepTime(time);
              Database? db = await DataBase.get();
              await TrackerDB.update(db!, widget.tracker);
            },
          ),
          ListTile(
            enabled: widget.tracker.phoneNumber.isNotEmpty,
            leading: const Icon(Icons.info_outline),
            title: Text(Locales.get('getInfo', context)),
            onTap: () async {
              widget.tracker.getTrackerInfo();
            },
          ),
          ListTile(
              leading: const Icon(Icons.sms_rounded),
              title: Text(Locales.get('messages', context)),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TrackerMessageListScreen(widget.tracker);
                }));
              }),
          ListTile(
              leading: const Icon(Icons.list),
              title: Text(Locales.get('details', context)),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TrackerDetailsScreen(widget.tracker);
                }));
              }),
        ],
      ),
    );

    List<Widget> form = [
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
            suffixIcon: IconButton(
                icon: const Icon(Icons.contact_phone, color: Colors.grey),
                onPressed: () async {
                  final PhoneContact contact =
                      await FlutterContactPicker.pickPhoneContact();
                  if (contact.phoneNumber?.number != null) {
                    String number = contact.phoneNumber?.number ?? '';
                    setState(() {
                      widget.tracker.phoneNumber = number;
                    });
                  }
                })),
        onChanged: (value) => widget.tracker.phoneNumber = value,
      )
    ];

    List<Widget> buttons = [
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
                      }),
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
          }),
      ElevatedButton(
          child: Text(Locales.get('history', context)),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return TrackerPositionListScreen(widget.tracker);
            }));
          })
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('editTracker', context)),
      ),
      drawer: drawer,
      body: Form(
        key: formKey,
        child: ListView(
          children: [...form, ...buttons],
        ),
      ),
      floatingActionButton: widget.tracker.phoneNumber.isEmpty
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () async {
                widget.tracker.requestLocation();
                Modal.toast(context, Locales.get('requestedPosition', context));
              },
              child: const Icon(Icons.gps_fixed),
            ),
    );
  }
}
