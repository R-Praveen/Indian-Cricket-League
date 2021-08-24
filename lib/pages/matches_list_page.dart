import 'package:flutter/material.dart';
import 'package:indian_cricket_league/bloc/matches_bloc.dart';
import 'package:indian_cricket_league/components/match_card.dart';
import 'package:indian_cricket_league/helpers/constants.dart';
import 'package:indian_cricket_league/models/match_details_model.dart';
import 'package:indian_cricket_league/pages/login_form_page.dart';
import 'package:indian_cricket_league/pages/match_details_page.dart';
import 'package:indian_cricket_league/providers/providers.dart';
import 'package:provider/provider.dart';

class MatchesListPage extends StatelessWidget {
  static const route = '/matchesListPage';
  const MatchesListPage();

  @override
  Widget build(BuildContext context) {
    return Provider<MatchesBloc>(
      create: (_) => MatchesBloc(
        signInServices: provideSignInServices(),
        firebaseServices: provideFirebaseServices(),
      ),
      child: _Body(),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  MatchesBloc? _bloc;

  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      _bloc?.fetchNextMatches();
    }
  }

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = Provider.of<MatchesBloc>(context);
      controller.addListener(_scrollListener);
      _bloc!.isLoggedOut.listen((value) {
        if (value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginFormPage.route, (route) => false);
        }
      });
      _bloc!.askForLoggingOut.listen((value) {
        if (value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  title: Text("Are you sure to Log out?"),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Material(
                        elevation: 8,
                        color: Color(0xdd191970),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide.none,
                        ),
                        child: InkWell(
                          onTap: () {
                            _bloc!.signOutUser();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 25,
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming matches"),
        backgroundColor: Color(0xdd191970),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _bloc!.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<MatchDetailsModel>>(
          stream: _bloc?.matchesList,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty ?? false) {
                final data = snapshot.data ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Flexible(
                            child: StreamBuilder<List<String>>(
                                stream: _bloc!.filtersApplied,
                                builder: (context, snapshot) {
                                  final list = snapshot.data ?? [];
                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    children: [
                                      ...yearOfMatches.map((e) {
                                        return SizedBox(
                                          height: 10,
                                          child: InkWell(
                                            onTap: () {
                                              _bloc!.onChangesFilters(e);
                                            },
                                            child: Card(
                                              elevation: 8,
                                              color: list.contains(e)
                                                  ? Colors.indigo
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 8),
                                                margin: EdgeInsets.all(8),
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                    color: list.contains(e)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MatchDetailsPage.route,
                                    arguments: data[index],
                                  );
                                },
                                child: MatchCard(
                                  matchDetailsModel: data[index],
                                ),
                              ),
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                      stream: _bloc?.isLoading,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && (snapshot.data ?? false)) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text("Fetching matches..."),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                );
              }
              return Center(
                child: Text("No matches to show"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
