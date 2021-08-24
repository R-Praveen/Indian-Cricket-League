String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';

RegExp regExp = RegExp(emailPattern);
RegExp regExpPassword = RegExp(passwordPattern);

bool validateEmailIsValid(String email) {
  return regExp.hasMatch(email);
}

bool isValidPassword(String password) {
  return regExpPassword.hasMatch(password);
}

String? validateEmail(String? value) {
  String? errorValue;
  if (value == null) {
    errorValue = "Please enter the email";
  } else if (!validateEmailIsValid(value)) {
    errorValue = "Please enter valid email";
  } else {
    errorValue = null;
  }
  return errorValue;
}

String? validatePassword(String? value) {
  String? errorValue;
  if (value == null) {
    errorValue = "Please enter the password";
  } else if (!isValidPassword(value)) {
    errorValue = "Please enter the valid password";
  } else {
    errorValue = null;
  }

  return errorValue;
}

String? validateConfirmPassword(
    String paswordValue, String? confirmPasswordValue) {
  String? errorValue;
  if (confirmPasswordValue == null) {
    errorValue = "Please enter the password again";
  } else if (paswordValue != confirmPasswordValue) {
    errorValue = "Passwords doesn't match";
  } else {
    errorValue = null;
  }
  return errorValue;
}
