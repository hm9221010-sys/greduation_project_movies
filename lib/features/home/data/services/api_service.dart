import 'package:dio/dio.dart';
import '../movie_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await _dio.get(
        'https://yts.lt/api/v2/list_movies.json?limit=50',
      );

      List data = response.data['data']['movies'];

      List<MovieModel> movies = data
          .map((json) => MovieModel.fromJson(json))
          .toList();

      return movies;
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<MovieModel>> getMoviesByGenre(
      String genre, {
        int page = 1,
      }) async {
    try {
      final response = await _dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {
          'genre': genre,
          'limit': 20,
          'page': page,
        },
      );

      List data = response.data['data']['movies'] ?? [];

      List<MovieModel> movies = data
          .map((json) => MovieModel.fromJson(json))
          .toList();

      return movies;
    } catch (e) {
      throw Exception(
        'Failed to load $genre movies: $e',
      );
    }
  }
}