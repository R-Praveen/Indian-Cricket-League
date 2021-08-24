import 'package:indian_cricket_league/helpers/constants.dart';
import 'package:indian_cricket_league/helpers/helpers.dart';
import 'package:indian_cricket_league/models/match_details_model.dart';
import 'package:rxdart/rxdart.dart';

class MatchDetailsPageBloc {
  final MatchDetailsModel matchDetailsModel;
  final assetString = BehaviorSubject<String>();
  final resultDetails = BehaviorSubject<String>();
  final tossDetails = BehaviorSubject<String>();
  MatchDetailsPageBloc({required this.matchDetailsModel}) {
    initDetails();
  }
  Future initDetails() async {
    assetString.add(getAssetString(matchDetailsModel.winner));
    resultDetails.add(getResultDetails());
    tossDetails.add(getTossDetails());
  }

  String getResultDetails() {
    if (matchDetailsModel.result == MatchResults.tie) {
      return "Tie";
    } else {
      if (matchDetailsModel.winByRuns != "0") {
        return '${matchDetailsModel.winner} won by ${matchDetailsModel.winByRuns} runs.';
      } else if (matchDetailsModel.winByWickets != "0") {
        return '${matchDetailsModel.winner} won by ${matchDetailsModel.winByWickets} wickets.';
      }
    }
    return '-';
  }

  String getTossDetails() {
    return '${matchDetailsModel.tossWinner} won the toss and chose to ${matchDetailsModel.tossDecision} first.';
  }

  void dispose() {
    assetString.close();
  }
}
