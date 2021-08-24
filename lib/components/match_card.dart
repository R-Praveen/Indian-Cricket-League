import 'package:flutter/material.dart';
import 'package:indian_cricket_league/helpers/helpers.dart';
import 'package:indian_cricket_league/models/match_details_model.dart';

class MatchCard extends StatelessWidget {
  final MatchDetailsModel? matchDetailsModel;
  const MatchCard({
    @required this.matchDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(matchDetailsModel?.teamOne ?? '-'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            getAssetString(matchDetailsModel?.teamOne ?? ''),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            getShortFormNames(matchDetailsModel?.teamOne ?? ''),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(" vs "),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        matchDetailsModel?.teamTwo ?? '-',
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            getAssetString(matchDetailsModel?.teamTwo ?? ''),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            getShortFormNames(matchDetailsModel?.teamTwo ?? ''),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(matchDetailsModel?.result == "normal" ? "Completed" : "Tie"),
          ],
        ),
      ),
    );
  }
}
