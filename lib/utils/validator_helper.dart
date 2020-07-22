import 'package:email_validator/email_validator.dart';

class ValidatorHelper {
  static String emailValidator(String email) {
    if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  static String passwordValidator(String password) {
    if (password.trim().length < 7) {
      return 'Please enter a password with a length of at least 8';
    } else {
      return null;
    }
  }

  static String confirmPasswordValidator(
      String password, String confirmPassword) {
    if (password.trim() != confirmPassword.trim()) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }

  static String firstNameValidator(String firstName) {
    if (firstName == null || firstName.trim().length == 0) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String lastNameValidator(String lastName) {
    if (lastName == null || lastName.trim().length == 0) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String phoneNumberValidator(String phoneNumber) {
    if (int.tryParse(phoneNumber.trim()) == null) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }

  static String petIdValidator(String petId) {
    if (petId.trim().length != 6) {
      return 'Please enter a valid pet id';
    } else {
      return null;
    }
  }
}
