import 'package:indian_cricket_league/helpers/validators.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';
import 'package:rxdart/rxdart.dart';

class LoginFormPageBloc {
  final email = BehaviorSubject<String?>();
  final password = BehaviorSubject<String?>();
  final obscurePassword = BehaviorSubject.seeded(true);
  final emailError = BehaviorSubject<String?>();
  final passwordError = BehaviorSubject<String?>();
  final showMessage = BehaviorSubject<String>();
  final SignInServices signInServices;

  LoginFormPageBloc({
    required this.signInServices,
  });

  void onChangedEmail(String? value) {
    email.add(value);
    emailError.add(validateEmail(value));
  }

  void onChangedPassword(String? value) {
    password.add(value);
    passwordError.add(validatePassword(value));
  }

  void onChangedPasswordVisibility() {
    obscurePassword.add(!obscurePassword.valueWrapper!.value);
  }

  bool isValid() {
    bool _isValid = true;
    final emailValue = email.valueWrapper?.value;
    final passwordValue = password.valueWrapper?.value;
    final emailErrorValue = validateEmail(emailValue);
    emailError.add(emailErrorValue);
    final passwordErrorValue = validatePassword(passwordValue);
    passwordError.add(passwordErrorValue);
    _isValid = emailErrorValue?.isEmpty ?? true;
    _isValid = passwordErrorValue?.isEmpty ?? true;
    return _isValid;
  }

  Future sign() async {
    if (!isValid()) {
      return;
    }
    Map<String, dynamic> userData = {
      "email": email.valueWrapper!.value,
      "password": password.valueWrapper!.value
    };
    try {
      final userCredential = await signInServices.loginUser(userData);
      if (userCredential != null) {
        showMessage.add("success");
      }
    } on UserNotFoundException {
      showMessage.add("Please register the user first before login");
    } on WrongPasswordException {
      showMessage.add("Please enter the correct password");
    } on ServerException {
      showMessage.add("Server Exception. Please try after some time.");
    }
  }

  void dispose() {
    email.close();
    password.close();
    emailError.close();
    passwordError.close();
    obscurePassword.close();
    showMessage.close();
  }
}
