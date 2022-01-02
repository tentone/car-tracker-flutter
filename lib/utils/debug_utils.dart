import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Console class stores static method to log information into the development console.
///
/// Provides a more complete output of the data.
class DebugUtils
{

  /// Log a object value into the console in a JSON like structure.
  ///
  /// @param obj Object to be printed into the console.
  static void log(dynamic obj)
  {
    Map jsonMapped = json.decode(json.encode(obj));

    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    String prettyPrint = encoder.convert(jsonMapped);

    debugPrint(prettyPrint);
  }
}