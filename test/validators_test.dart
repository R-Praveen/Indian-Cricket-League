import 'package:flutter_test/flutter_test.dart';
import 'package:indian_cricket_league/helpers/validators.dart';

void main() {
  String emailOne = "rock.ipl";
  String emailTwo = "rock@wwe.com";
  String passwordOne = "abcdef";
  String passwordTwo = "RockBottom8!";

  group("test the possible cases of email validation", () {
    test("test the email is valid or not", () {
      expect(validateEmailIsValid(emailOne), false);
    });
    test("test the email is valid or not", () {
      expect(validateEmailIsValid(emailTwo), true);
    });
  });

  group("test the possible cases of password validation", () {
    test("test the password is valid or not", () {
      expect(isValidPassword(passwordOne), false);
    });
    test("test the password is valid or not", () {
      expect(isValidPassword(passwordTwo), true);
    });
  });

  group(
      "test the possible cases of email validation and get error messages correctly",
      () {
    test("get the error message for invalid email", () {
      expect(validateEmail(emailOne), "Please enter valid email");
    });
    test("get error message as null for valid email", () {
      expect(validateEmail(emailTwo), null);
    });
  });

  group("test the possible cases of password validation and get error message",
      () {
    test("get the password proper error message for in valid passsword", () {
      expect(validatePassword(passwordOne), "Please enter the valid password");
    });
    test("get the password value as null for valid password", () {
      expect(validatePassword(passwordTwo), null);
    });
  });

  group(
      "test the possible cases of confirm password validation and get error message",
      () {
    test(
        "get the confirm password proper error message for in valid confirm passsword",
        () {
      expect(validateConfirmPassword(passwordOne, passwordTwo),
          "Passwords doesn't match");
    });
    test("get the password value as null for valid password", () {
      expect(validateConfirmPassword(passwordTwo, passwordTwo), null);
    });
  });
}
