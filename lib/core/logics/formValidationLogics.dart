class FormValidation {
  static String isEmpty(value) {
    if (value.isEmpty) {
      return 'This information is required';
    }

    return null;
  }

  static String isPin(String value) {
    if (value.length < 4 || value.length > 4) {
      return 'Pin must be four (4) digits';
    }

    return null;
  }

  static String isOTP(String value) {
    if (value.length < 4) {
      return 'OTP must be six (4) digits';
    }

    return null;
  }

  static String isDouble(String value) {
    if (value.isEmpty) {
      return 'Input required. \n';
    } else {
      try {
        double val = double.parse(value);
        if (val > 0) {
          return null;
        } else {
          return 'Please value must be greater than 0.\n';
        }
      } catch (err) {
        return 'Please enter a valid number.\n';
      }
    }
  }

  String checkAmount(value, ladder) {
    if (value.isEmpty) {
      return '';
    }

    if (int.parse(value) < 1000) {
      return 'The minimum amount is 1000';
    }

    if (int.parse(value) > 1000000) {
      return 'The maximum amount is 1000000';
    }

    return null;
  }

  static String isEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(
            "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }

    // validator has to return something :)
    return null;
  }

  static String isPhone(String value) {
    Pattern pattern = r'(^(?:[+]234)[0-9]{10}$)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Format phone number as +234**********';
    } else {
      return null;
    }
  }

  static String checkName(String name) {
    name = name.trim();

    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(name)) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String isPassword(String value) {
    if (value.length < 6) {
      return 'Minimum of 6 characters required.';
    } else {
      return null;
    }
  }
}
