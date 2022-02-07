import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locale/locales.dart';

class ModalOption {
  /// Text of this option
  final String text;

  /// Callback to be executed if this option is selected
  final void Function()? callback;

  const ModalOption(this.text, this.callback);
}

class Modal {
  /// Show a toast message to the users.
  static void toast(BuildContext context, String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  /// Show a alert modal
  ///
  /// The onCancel callbacks receive BuildContext context as argument.
  static void alert(BuildContext context, String title, String message, {Function? onCancel}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              actions: [
                TextButton(
                  child: Text(Locales.get('ok', context)),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancel != null) {
                      onCancel();
                    }
                  },
                )
              ],
              content: Text(message));
        });
  }

  /// Show dialog message to question between multiple options.
  static Future<void> question(BuildContext context, String title, List<ModalOption> options) async {
    List<TextButton> actions = [];

    for (int i = 0; i < options.length; i++) {
      actions.add(TextButton(child: Text(options[i].text), onPressed: options[i].callback));
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(title), actions: actions);
      }
    );
  }

  /// Show a confirm modal with ok and cancel buttons
  ///
  /// The onConfirm and onCancel callbacks receive BuildContext context as argument.
  static void confirm(BuildContext context, String title, String message, {Function? onConfirm, Function? onCancel}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              actions: [
                TextButton(
                  child: Text(Locales.get('ok', context)),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onConfirm != null) {
                      onConfirm(context);
                    }
                  },
                ),
                TextButton(
                  child: Text(Locales.get('cancel', context)),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancel != null) {
                      onCancel(context);
                    }
                  },
                )
              ],
              content: Text(message));
        });
  }
}
