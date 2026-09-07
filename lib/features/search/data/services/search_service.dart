import 'package:dio/dio.dart';
import '../../../home/data/movie_model.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {
          'query_term': query,
          'limit': 50,
        },
      );

      List data = response.data['data']['movies'] ?? [];

      List<MovieModel> movies = data.map((json) => MovieModel.fromJson(json)).toList();
      return movies;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}