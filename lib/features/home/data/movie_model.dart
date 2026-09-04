class MovieModel {
  final String posterUrl;
  final String rating;
  final DateTime releaseDate;

  MovieModel({
    required this.posterUrl,
    required this.rating,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      posterUrl: json['poster_path'] ?? '',
      rating: json['vote_average']?.toString() ?? '0.0',
      releaseDate: json['release_date'] != null
          ? DateTime.parse(json['release_date'])
          : DateTime.now(),
    );
  }
}