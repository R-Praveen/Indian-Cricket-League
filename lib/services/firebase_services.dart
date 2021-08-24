import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future fetchNextmatches(
      QueryDocumentSnapshot<Map<String, dynamic>> lastVisible,
      List<String> filters) async {
    List<int>? list;
    if (filters.isNotEmpty) {
      list = filters.map((e) => int.parse(e)).toList();
    }
    return fireStore
        .collection('matches')
        .where(
          'season',
          whereIn: list,
        )
        .startAfterDocument(lastVisible)
        .limit(10)
        .get();
  }

  Future fetchFilteredMatches(List<String> filters) async {
    List<int>? list;
    if (filters.isNotEmpty) {
      list = filters.map((e) => int.parse(e)).toList();
    }
    try {
      return fireStore
          .collection('matches')
          .orderBy("id")
          .where(
            'season',
            whereIn: list,
          )
          .limit(10)
          .get();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
