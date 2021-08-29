import 'package:indian_cricket_league/helpers/validators.dart';
import 'package:indian_cricket_league/repository/sign_in_repository.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';
import 'package:rxdart/subjects.dart';

class SignUpFormPageBloc {
  final email = BehaviorSubject<String?>();
  final password = BehaviorSubject<String?>();
  final confirmPassword = BehaviorSubject<String?>();
  final showMessage = BehaviorSubject<String>();
  final obscurePassword = BehaviorSubject.seeded(true);
  final obscureConfirmPassword = BehaviorSubject.seeded(true);
  final emailError = BehaviorSubject<String?>();
  final passwordError = BehaviorSubject<String?>();
  final confirmPasswordError = BehaviorSubject<String?>();
  final SignInRepository signInRepository;

  SignUpFormPageBloc({
    required this.signInRepository,
  });

  void onChangedEmail(String? value) {
    email.add(value);
    emailError.add(validateEmail(value));
  }

  void onChangedPassword(String? value) {
    password.add(value);
    passwordError.add(validatePassword(value));
  }

  void onChangedConfirmPassword(String? value) {
    confirmPassword.add(value);
    String passwordValue = password.valueWrapper!.value ?? '';
    confirmPasswordError.add(
      validateConfirmPassword(passwordValue, value),
    );
  }

  void onChangedPasswordVisibility() {
    obscurePassword.add(!obscurePassword.valueWrapper!.value);
  }

  void onChangedConfirmPasswordVisibility() {
    obscureConfirmPassword.add(!obscureConfirmPassword.valueWrapper!.value);
  }

  bool isValid() {
    bool _isValid = true;
    final emailValue = email.valueWrapper?.value;
    final passwordValue = password.valueWrapper?.value ?? '';
    final confirmPasswordValue = confirmPassword.valueWrapper?.value;
    final emailErrorValue = validateEmail(emailValue);
    emailError.add(emailErrorValue);
    final passwordErrorValue = validatePassword(passwordValue);
    passwordError.add(passwordErrorValue);
    final confirmPasswordErrorValue =
        validateConfirmPassword(passwordValue, confirmPasswordValue);
    confirmPasswordError.add(confirmPasswordErrorValue);
    _isValid = emailErrorValue?.isEmpty ?? true;
    _isValid = passwordErrorValue?.isEmpty ?? true;
    _isValid = confirmPasswordErrorValue?.isEmpty ?? true;
    return _isValid;
  }

  Future signUpUser() async {
    if (!isValid()) {
      return;
    }
    Map<String, dynamic> userData = {
      "email": email.valueWrapper!.value,
      "password": password.valueWrapper!.value
    };
    try {
      final userCredential = await signInRepository.createUser(userData);
      if (userCredential != null) {
        showMessage.add("User created successfully. Please login");
      }
    } on WeakPasswordException {
      showMessage.add("Please enter a Strong password");
    } on EmailAlreadyInUseException {
      showMessage.add("Email is already registerred please login");
    } on ServerException {
      showMessage.add("Server Exception. Please try after some time.");
    }
  }

  void dispose() {
    email.close();
    password.close();
    confirmPassword.close();
    emailError.close();
    passwordError.close();
    confirmPasswordError.close();
    obscurePassword.close();
    obscureConfirmPassword.close();
    showMessage.close();
  }
}
