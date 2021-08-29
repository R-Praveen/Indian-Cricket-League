import 'package:indian_cricket_league/services/sign_in_services.dart';

class SignInRepository {
  SignInServices services;

  SignInRepository({
    required this.services,
  });

  Future<bool> isUserLoggedIn() async {
    return services.isUserLoggedIn();
  }

  Future createUser(Map<String, dynamic> userData) async {
    try {
      await services.createUser(userData);
    } catch (e) {
      rethrow;
    }
  }

  Future loginUser(Map<String, dynamic> userData) async {
    try {
      await services.loginUser(userData);
    } catch (e) {
      rethrow;
    }
  }

  Future signOut() async {
    await services.signOut();
  }
}
