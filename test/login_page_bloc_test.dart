import 'package:flutter_test/flutter_test.dart';
import 'package:indian_cricket_league/bloc/login_page_bloc.dart';
import 'package:indian_cricket_league/repository/sign_in_repository.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_page_bloc_test.mocks.dart';

@GenerateMocks([SignInRepository, SignInServices])
void main() {
  late MockSignInServices mockSignInServices;
  late MockSignInRepository mockSignInRepository;
  late LoginPageBloc loginPageBloc;
  setUp(() {
    mockSignInServices = MockSignInServices();
    mockSignInRepository = MockSignInRepository();
  });

  test("testing the user logged in credentials", () async {
    when(mockSignInRepository.isUserLoggedIn()).thenAnswer(
      (_) => Future.value(true),
    );
    loginPageBloc = LoginPageBloc(signInRepository: mockSignInRepository);
    await loginPageBloc.initDetails();
    expect(loginPageBloc.userLoggedIn.valueWrapper?.value, true);
  });

  test("testing the user logged in credentials if not there", () async {
    when(mockSignInRepository.isUserLoggedIn()).thenAnswer(
      (_) => Future.value(false),
    );
    loginPageBloc = LoginPageBloc(signInRepository: mockSignInRepository);
    await loginPageBloc.initDetails();
    expect(loginPageBloc.userLoggedIn.valueWrapper?.value, null);
  });
}
