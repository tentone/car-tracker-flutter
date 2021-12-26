import 'package:flutter/material.dart';

import '../../locale/locales.dart';

class ModalOption
{
  /// Text of this option
  final String text;

  /// Callback to be executed if this option is selected
  final void Function()? callback;

  const ModalOption(this.text, this.callback);
}

class Modal
{
  /// Show a alert modal
  ///
  /// The onCancel callbacks receive BuildContext context as argument.
  static void alert(BuildContext context, String title, String message, {Function ?onCancel})
  {
    showDialog
    (
      context: context,
      builder: (BuildContext context)
      {

        return AlertDialog
        (
          title: Text(title),
          actions: 
          [
            TextButton
            (
              child: Text(Locales.get('ok', context)),
              onPressed:()
              {
                Navigator.pop(context);
                if(onCancel != null)
                {
                  onCancel();
                }
              },
            )
          ],
          content: Text(message)
        );
      }
    );
  }

  /// Show dialog message to question between multiple options.
  static void question(BuildContext context, String title, String message, List<ModalOption> options)
  {
    List <TextButton> actions = [];

    for(int i = 0; i < options.length; i++)
    {
      actions.add(TextButton
      (
        child: Text(options[i].text),
        onPressed: options[i].callback
      ));
    }

    showDialog
    (
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text(title),
          actions: actions,
          content: Text(message)
        );
      }
    );
  }

  /// Show a confirm modal with ok and cancel buttons
  ///
  /// The onConfirm and onCancel callbacks receive BuildContext context as argument.
  static void confirm(BuildContext context, String title, String message, {Function ?onConfirm, Function ?onCancel})
  {
    showDialog
    (
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text(title),
          actions:
          [
            TextButton
            (
              child: Text(Locales.get('ok', context)),
              onPressed:()
              {
                Navigator.pop(context);
                if(onConfirm != null)
                {
                  onConfirm(context);
                }
              },
            ),
            TextButton
            (
              child: Text(Locales.get('cancel', context)),
              onPressed:()
              {
                Navigator.pop(context);
                if(onCancel != null)
                {
                  onCancel(context);
                }
              },
            )
          ],
          content: Text(message)
        );
      }
    );
  }
}