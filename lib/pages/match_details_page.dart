import 'package:flutter/material.dart';
import 'package:indian_cricket_league/bloc/match_details_page_bloc.dart';
import 'package:indian_cricket_league/models/match_details_model.dart';
import 'package:provider/provider.dart';

class MatchDetailsPage extends StatelessWidget {
  static const route = '/matchDetailsPage';
  @override
  Widget build(BuildContext context) {
    final matchDetailsModel = (ModalRoute.of(context)?.settings.arguments ??
        null) as MatchDetailsModel;
    return Provider<MatchDetailsPageBloc>(
      create: (_) => MatchDetailsPageBloc(
        matchDetailsModel: matchDetailsModel,
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MatchDetailsPageBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  StreamBuilder<String>(
                    stream: bloc.assetString,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final imageString = snapshot.data as String;
                        return Image.asset(
                          imageString,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.5,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  Positioned(
                    top: 80,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<String>(
                stream: bloc.resultDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (bloc.matchDetailsModel.dlApplied != "0")
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text("D/L method"),
                          )
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(bloc.matchDetailsModel.teamOne),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    " vs ".toUpperCase(),
                    style: TextStyle(
                      color: Color(0xdd191970),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      bloc.matchDetailsModel.teamTwo,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Toss: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<String>(
                      stream: bloc.tossDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data ?? '');
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Venue: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(bloc.matchDetailsModel.date),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Venue: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(bloc.matchDetailsModel.venue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Player of the match: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(bloc.matchDetailsModel.playerOfMatch),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Umpires:  ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bloc.matchDetailsModel.umpireOne,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          bloc.matchDetailsModel.umpireTwo,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        if (bloc.matchDetailsModel.umpireThree.isNotEmpty)
                          Text(
                            '${bloc.matchDetailsModel.umpireThree} (3rd Umpire)',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
