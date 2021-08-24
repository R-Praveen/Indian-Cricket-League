import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:indian_cricket_league/models/match_details_model.dart';
import 'package:indian_cricket_league/services/firebase_services.dart';
import 'package:indian_cricket_league/services/sign_in_services.dart';
import 'package:rxdart/subjects.dart';

class MatchesBloc {
  final matchesList = BehaviorSubject<List<MatchDetailsModel>>();
  final lastVisible =
      BehaviorSubject<QueryDocumentSnapshot<Map<String, dynamic>>>();
  final isLoading = BehaviorSubject<bool>();
  final askForLoggingOut = BehaviorSubject<bool>();
  final isLoggedOut = BehaviorSubject<bool>();
  final filtersApplied = BehaviorSubject<List<String>>.seeded(
    [],
  );
  final SignInServices signInServices;
  final FirebaseServices firebaseServices;
  MatchesBloc({
    required this.signInServices,
    required this.firebaseServices,
  }) {
    initPageDetails();
  }

  Future initPageDetails() async {
    await firebaseServices
        .fetchFilteredMatches(filtersApplied.valueWrapper!.value)
        .then((value) {
      processAfterFetch(value);
    });
  }

  Future fetchNextMatches() async {
    isLoading.add(true);
    await firebaseServices
        .fetchNextmatches(
      lastVisible.valueWrapper!.value,
      filtersApplied.valueWrapper!.value,
    )
        .then((value) {
      processAfterFetch(value);
      isLoading.add(false);
    });
  }

  void processAfterFetch(value, {bool shouldReset = false}) {
    final _list = <MatchDetailsModel>[];
    final docList = value.docs;
    lastVisible.add(docList[docList.length - 1]);
    value.docs.forEach((element) {
      try {
        _list.add(
          MatchDetailsModel.fromJson(
            element.data(),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    List<MatchDetailsModel> existingMatchesList = <MatchDetailsModel>[];
    if (!shouldReset) {
      existingMatchesList =
          matchesList.valueWrapper?.value ?? <MatchDetailsModel>[];
    }
    existingMatchesList..addAll(_list);
    matchesList.add(existingMatchesList);
  }

  Future onChangesFilters(String season) async {
    List<String> list = filtersApplied.valueWrapper?.value ?? <String>[];
    if (list.contains(season)) {
      list.remove(season);
    } else {
      list.add(season);
    }
    await firebaseServices.fetchFilteredMatches(list).then((value) {
      processAfterFetch(value, shouldReset: true);
    });
    filtersApplied.add(list);
  }

  void signOut() {
    askForLoggingOut.add(true);
  }

  Future signOutUser() async {
    await signInServices.signOut().then((value) {
      isLoggedOut.add(true);
    });
  }

  void dispose() {
    matchesList.close();
    isLoggedOut.close();
    askForLoggingOut.close();
  }
}
