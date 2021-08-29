import 'package:flutter/material.dart';
import 'package:indian_cricket_league/bloc/sign_up_form_page_bloc.dart';
import 'package:indian_cricket_league/components/app_button.dart';
import 'package:indian_cricket_league/components/text_field_email.dart';
import 'package:indian_cricket_league/components/text_field_password_widget.dart';
import 'package:indian_cricket_league/providers/providers.dart';
import 'package:provider/provider.dart';

class SignUpFormPage extends StatelessWidget {
  static const route = '/signUpFormPage';
  const SignUpFormPage();

  @override
  Widget build(BuildContext context) {
    return Provider<SignUpFormPageBloc>(
      create: (_) => SignUpFormPageBloc(
        signInRepository: provideSignInRepository(),
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  SignUpFormPageBloc? _bloc;

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = Provider.of<SignUpFormPageBloc>(context);
      _bloc!.showMessage.listen((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value),
          ),
        );
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/ipl.png',
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  StreamBuilder<String?>(
                      stream: _bloc!.emailError,
                      builder: (context, snapshot) {
                        return TextFieldEmailWidget(
                          error: _bloc!.emailError,
                          onChanged: _bloc!.onChangedEmail,
                          hintText: 'Email',
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<String?>(
                      stream: _bloc!.passwordError,
                      builder: (context, snapshot) {
                        return StreamBuilder<bool>(
                            stream: _bloc!.obscurePassword,
                            builder: (context, obscureStatus) {
                              return TextFieldPasswordWidget(
                                error: _bloc!.passwordError,
                                obscure: _bloc!.obscurePassword,
                                onChanged: _bloc!.onChangedPassword,
                                hintText: 'Password',
                                onChangedPasswordVisibility:
                                    _bloc!.onChangedPasswordVisibility,
                              );
                            });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<String?>(
                      stream: _bloc!.confirmPasswordError,
                      builder: (context, snapshot) {
                        return StreamBuilder<bool>(
                            stream: _bloc!.obscureConfirmPassword,
                            builder: (context, obscureStatus) {
                              return TextFieldPasswordWidget(
                                error: _bloc!.confirmPasswordError,
                                obscure: _bloc!.obscureConfirmPassword,
                                onChanged: _bloc!.onChangedConfirmPassword,
                                hintText: 'Confirm Password',
                                onChangedPasswordVisibility:
                                    _bloc!.onChangedConfirmPasswordVisibility,
                              );
                            });
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    name: "Sign up",
                    backgroundColor: Color(0xdd191970),
                    onSurfaceColor: Colors.white,
                    textColor: Colors.white,
                    onChanged: () {
                      _bloc!.signUpUser();
                    },
                    primaryColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
