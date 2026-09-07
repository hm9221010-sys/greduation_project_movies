import 'package:greduation_movies_fluter/features/home/data/movie_model.dart';
import 'package:dio/dio.dart';

class ApiManager {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://yts.mx/api/v2/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<List<MovieModel>> getMovies({String? genre, String? queryTerm}) async {
    try {
      final response = await _dio.get(
        'list_movies.json',
        queryParameters: {
          if (genre != null) 'genre': genre,
          if (queryTerm != null) 'query_term': queryTerm,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        List? moviesJson = response.data['data']['movies'];
        if (moviesJson == null) return [];
        return moviesJson.map((e) => MovieModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  static Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        'movie_details.json',
        queryParameters: {'movie_id': movieId},
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        return MovieModel.fromJson(response.data['data']['movie']);
      }
      throw Exception('Failed to load movie details');
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }

  static Future<List<MovieModel>> getMovieSuggestions(int movieId) async {
    try {
      final response = await _dio.get(
        'movie_suggestions.json',
        queryParameters: {'movie_id': movieId},
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        List? moviesJson = response.data['data']['movies'];
        if (moviesJson == null) return [];
        return moviesJson.map((e) => MovieModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load suggestions: $e');
    }
  }
}