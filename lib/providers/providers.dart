import 'package:indian_cricket_league/services/firebase_services.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';

SignInServices provideSignInServices() {
  return SignInServices();
}

FirebaseServices provideFirebaseServices() {
  return FirebaseServices();
}
