import 'package:indian_cricket_league/repository/sign_in_repository.dart';
import 'package:indian_cricket_league/services/firebase_services.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';

SignInRepository provideSignInRepository() {
  return SignInRepository(
    services: provideSignInServices(),
  );
}

SignInServices provideSignInServices() {
  return SignInServices();
}

FirebaseServices provideFirebaseServices() {
  return FirebaseServices();
}
