import 'package:flutter/material.dart';
import 'package:indian_cricket_league/pages/login_form_page.dart';
import 'package:indian_cricket_league/pages/login_page.dart';
import 'package:indian_cricket_league/pages/match_details_page.dart';
import 'package:indian_cricket_league/pages/matches_list_page.dart';
import 'package:indian_cricket_league/pages/sign_up_form_page.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  LoginPage.route: (_) => LoginPage(),
  LoginFormPage.route: (_) => LoginFormPage(),
  SignUpFormPage.route: (_) => SignUpFormPage(),
  MatchesListPage.route: (_) => MatchesListPage(),
  MatchDetailsPage.route: (_) => MatchDetailsPage(),
};