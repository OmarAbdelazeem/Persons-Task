import 'package:sofico_task/res/strings_constants.dart';

class Validator {
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return StringsConstants.nameIsRequired;
    }
    return null;
  }

  String? validateAvatar(String? value) {
    if (value!.isEmpty) {
      return StringsConstants.avatarIsRequired;
    }
    bool _validURL = Uri.parse(value).isAbsolute;
    if (_validURL) {
      return null;
    } else
      return StringsConstants.invalidUrl;
  }

  String? validateEmail(String? value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return StringsConstants.emailIsRequired;
    } else if (!regExp.hasMatch(value)) {
      return StringsConstants.invalidEmail;
    } else {
      return null;
    }
  }

  String? validateCountry(String? value) {
    if (value!.isEmpty) {
      return StringsConstants.countryIsRequired;
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value!.isEmpty) {
      return StringsConstants.dateOfBirthIsRequired;
    }
    return null;
  }
}
