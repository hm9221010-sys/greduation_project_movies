import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/data/movie_model.dart';

class FavoriteService {
  static CollectionReference<Map<String, dynamic>>
  _getFavoriteCollection() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites');
  }

  static Future<void> addFavorite(
      MovieModel movie,
      ) async {
    await _getFavoriteCollection()
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
    });
  }

  static Future<void> removeFavorite(
      int movieId,
      ) async {
    await _getFavoriteCollection()
        .doc(movieId.toString())
        .delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
  getFavorites() {
    return _getFavoriteCollection()
        .snapshots();
  }
  static Future<bool> isFavorite(
      int movieId,
      ) async {
    final document = await _getFavoriteCollection()
        .doc(movieId.toString())
        .get();

    return document.exists;
  }
}