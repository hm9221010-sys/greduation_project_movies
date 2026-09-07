import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/movie_dart.dart';
import '../api/constants.dart';

class ApiManager {

  static Future<List<Movie>> getMovies() async {

    final url = Uri.parse(
      '${AppConstants.baseUrl}/movie/popular'
          '?api_key=${AppConstants.apiKey}'
          '&language=en-US'
          '&page=1',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List results = data['results'];

      return results
          .map((movie) => Movie.fromJson(movie))
          .toList();

    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Movie> getMovieDetails(
      int movieId) async {

    final url = Uri.parse(
      '${AppConstants.baseUrl}/movie/$movieId'
          '?api_key=${AppConstants.apiKey}'
          '&language=en-US'
          '&append_to_response=credits',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return Movie.fromJson(data);

    } else {
      throw Exception(
        'Failed to load movie details',
      );
    }
  }

  // Get movies by genre
  static Future<List<Movie>> getMoviesByGenre(
      int genreId) async {

    final url = Uri.parse(
      '${AppConstants.baseUrl}/discover/movie'
          '?api_key=${AppConstants.apiKey}'
          '&language=en-US'
          '&with_genres=$genreId'
          '&sort_by=popularity.desc'
          '&page=1',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List results = data['results'];

      return results
          .map((movie) => Movie.fromJson(movie))
          .toList();

    } else {
      throw Exception(
        'Failed to load movies by genre',
      );
    }
  }
}