import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/data/movie_model.dart';

class HistoryService {
  static CollectionReference<Map<String, dynamic>>
  _getHistoryCollection() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history');
  }

  static Future<void> addToHistory(
      MovieModel movie,
      ) async {
    await _getHistoryCollection()
        .doc(movie.id.toString())
        .set({
      'id': movie.id,
      'title': movie.title,
      'posterUrl': movie.posterUrl,
      'rating': movie.rating,
      'releaseDate':
      movie.releaseDate.toIso8601String(),
      'dateAdded':
      movie.dateAdded.toIso8601String(),
      'genres': movie.genres,
      'viewedAt':
      DateTime.now().toIso8601String(),
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
  getHistory() {
    return _getHistoryCollection()
        .orderBy(
      'viewedAt',
      descending: true,
    )
        .snapshots();
  }
}