import 'package:email_validator/email_validator.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';

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

  static String addressValidator(String address) {
    if (address == null || address.trim().length == 0) {
      return 'Please enter a valid address';
    } else {
      return null;
    }
  }

  static String petNameValidator(String petName) {
    if (petName == null || petName.trim().length == 0) {
      return 'Please enter a valid pet name';
    } else {
      return null;
    }
  }

  static String petSpeciesValidator(Species petSpecies) {
    if (petSpecies == null) {
      return 'Please select a species';
    } else {
      return null;
    }
  }

  static String petBreedValidator(String petBreed) {
    if (petBreed == null || petBreed.trim().length == 0) {
      return 'Please enter a valid pet breed';
    } else {
      return null;
    }
  }

  static String petColorValidator(String petColor) {
    if (petColor == null || petColor.trim().length == 0) {
      return 'Please enter a valid pet color';
    } else {
      return null;
    }
  }

  static String petTempValidator(String petTemp) {
    if (petTemp == null || petTemp.trim().length == 0) {
      return 'Please enter a valid pet name';
    } else {
      return null;
    }
  }

  static String petAddInfoValidator(String addInfo) {
    if (addInfo == null || addInfo.trim().length == 0) {
      return 'Please enter a valid pet name';
    } else {
      return null;
    }
  }

  static String petBirthdayValidator(String petBirthday) {
    if (petBirthday == null || petBirthday.trim().isEmpty) {
      return 'Please select a birthday';
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

  static String vaccinationNameValidator(String vaccinationName) {
    if (vaccinationName == null || vaccinationName.trim().isEmpty) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String reminderNameValidator(String reminderName) {
    if (reminderName == null || reminderName.trim().isEmpty) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String ownerNameValidator(String ownerName) {
    if (ownerName == null || ownerName.trim().isEmpty) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }
}
