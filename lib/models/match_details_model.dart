class MatchDetailsModel {
  final String cityName;
  final String playerOfMatch;
  final String id;
  final String dlApplied;
  final String result;
  final String season;
  final String teamOne;
  final String teamTwo;
  final String tossDecision;
  final String tossWinner;
  final String umpireOne;
  final String umpireTwo;
  final String umpireThree;
  final String venue;
  final String winByRuns;
  final String winByWickets;
  final String winner;
  final String date;
  MatchDetailsModel({
    required this.cityName,
    required this.playerOfMatch,
    required this.id,
    required this.dlApplied,
    required this.result,
    required this.season,
    required this.teamOne,
    required this.teamTwo,
    required this.tossDecision,
    required this.tossWinner,
    required this.umpireOne,
    required this.umpireTwo,
    required this.umpireThree,
    required this.venue,
    required this.winByRuns,
    required this.winByWickets,
    required this.winner,
    required this.date,
  });

  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) {
    return MatchDetailsModel(
        cityName: json["city"],
        playerOfMatch: json["player_of_match"],
        id: json["id"].toString(),
        dlApplied: json["dl_applied"].toString(),
        result: json["result"],
        season: json["season"].toString(),
        teamOne: json["team1"],
        teamTwo: json["team2"],
        tossDecision: json["toss_decision"],
        tossWinner: json["toss_winner"],
        umpireOne: json["umpire1"],
        umpireTwo: json["umpire2"],
        umpireThree: json["umpire3"],
        venue: json["venue"],
        winByRuns: json["win_by_runs"].toString(),
        winByWickets: json["win_by_wickets"].toString(),
        winner: json["winner"],
        date: json["date"]);
  }
}
