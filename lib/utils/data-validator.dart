/// Auxiliary class used to validate if data is correctly formatted.
class DataValidator {
  /// Check if a string is a valid phone number.
  ///
  /// Considers international phone number formats w/ or without country code.
  ///
  /// e.g. +351123456789, 123456789, 123-456-789
  static bool phoneNumber(String? value) {
    if (value == null) {
      return false;
    }

    value = value.replaceAll(' ', '');

    RegExp regex = RegExp(r'((\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?)?\d{3}[\s.-]?\d{4}');

    return regex.hasMatch(value);
  }
}
