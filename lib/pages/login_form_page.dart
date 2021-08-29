import 'package:flutter/material.dart';
import 'package:indian_cricket_league/bloc/login_form_page_bloc.dart';
import 'package:indian_cricket_league/components/app_button.dart';
import 'package:indian_cricket_league/components/text_field_email.dart';
import 'package:indian_cricket_league/components/text_field_password_widget.dart';
import 'package:indian_cricket_league/pages/matches_list_page.dart';
import 'package:indian_cricket_league/pages/sign_up_form_page.dart';
import 'package:indian_cricket_league/providers/providers.dart';
import 'package:provider/provider.dart';

class LoginFormPage extends StatelessWidget {
  static const route = '/loginFormRoute';
  const LoginFormPage();

  @override
  Widget build(BuildContext context) {
    return Provider<LoginFormPageBloc>(
      create: (_) => LoginFormPageBloc(
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
  LoginFormPageBloc? _bloc;

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = Provider.of(context);
      _bloc!.showMessage.listen((value) {
        if (value == "success") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MatchesListPage.route, (route) => false);
          return;
        }
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
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/ipl.png',
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextFieldEmailWidget(
                    error: _bloc!.emailError,
                    onChanged: _bloc!.onChangedEmail,
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFieldPasswordWidget(
                    error: _bloc!.passwordError,
                    obscure: _bloc!.obscurePassword,
                    onChanged: _bloc!.onChangedPassword,
                    hintText: 'Password',
                    onChangedPasswordVisibility:
                        _bloc!.onChangedPasswordVisibility,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    name: "Login",
                    backgroundColor: Color(0xdd191970),
                    onSurfaceColor: Colors.white,
                    textColor: Colors.white,
                    onChanged: () {
                      _bloc!.sign();
                    },
                    primaryColor: Colors.white,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpFormPage.route);
                      },
                      child: Text(
                        "Click to register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
