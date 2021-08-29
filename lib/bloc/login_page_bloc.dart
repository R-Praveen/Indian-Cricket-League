import 'package:indian_cricket_league/repository/sign_in_repository.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';
import 'package:rxdart/rxdart.dart';

class LoginPageBloc {
  final userLoggedIn = BehaviorSubject<bool>();
  final isLoading = BehaviorSubject<bool>();
  final SignInRepository signInRepository;
  LoginPageBloc({
    required this.signInRepository,
  }) {
    initDetails();
  }

  Future initDetails() async {
    isLoading.add(true);
    final isUserLoggedIn = await signInRepository.isUserLoggedIn();
    if (isUserLoggedIn) {
      userLoggedIn.add(isUserLoggedIn);
    }
    isLoading.add(false);
  }

  void dispose() {
    userLoggedIn.close();
    isLoading.close();
  }
}
