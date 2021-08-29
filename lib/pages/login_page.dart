import 'package:flutter/material.dart';
import 'package:indian_cricket_league/bloc/login_page_bloc.dart';
import 'package:indian_cricket_league/components/app_button.dart';
import 'package:indian_cricket_league/pages/login_form_page.dart';
import 'package:indian_cricket_league/pages/matches_list_page.dart';
import 'package:indian_cricket_league/providers/providers.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const route = '/';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginPageBloc>(
      create: (_) => LoginPageBloc(
        signInRepository: provideSignInRepository(),
      ),
      dispose: (_, bloc) => bloc.dispose,
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  LoginPageBloc? _bloc;
  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = Provider.of<LoginPageBloc>(context);
      _bloc!.userLoggedIn.listen((value) {
        if (value) {
          Navigator.popAndPushNamed(context, MatchesListPage.route);
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xdd191970),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/icl3.jpeg",
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          SizedBox(height: 30),
          StreamBuilder<bool>(
              stream: _bloc!.isLoading,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data ?? false) {
                    return Positioned(
                      bottom: 20,
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return Positioned(
                      bottom: 20,
                      child: AppButton(
                        name: "Login",
                        backgroundColor: Colors.white,
                        onSurfaceColor: Colors.white,
                        textColor: Colors.black,
                        onChanged: () {
                          Navigator.pushNamed(context, LoginFormPage.route);
                        },
                        primaryColor: Colors.white,
                      ),
                    );
                  }
                }
                return const SizedBox();
              }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
