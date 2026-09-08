class MovieModel {
  final int id;
  final String title;
  final String posterUrl;
  final String rating;
  final DateTime releaseDate;
  final DateTime dateAdded;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.releaseDate,
    required this.dateAdded,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,

      title: json['title_long'] ?? json['title'] ?? '',

      posterUrl:
      json['large_cover_image'] ??
          json['medium_cover_image'] ??
          '',

      rating: json['rating']?.toString() ?? '0.0',

      releaseDate: json['year'] != null
          ? DateTime(json['year'] as int)
          : DateTime.now(),

      dateAdded: json['date_uploaded'] != null
          ? DateTime.tryParse(json['date_uploaded']) ??
          DateTime.now()
          : DateTime.now(),

      genres: json['genres'] != null
          ? List<String>.from(json['genres'])
          : [],
    );
  }
}