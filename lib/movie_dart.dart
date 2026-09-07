class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<String> genres;
  final List<Cast> cast;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    this.genres = const [],
    this.cast = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Get cast from credits
    List<Cast> castList = [];

    if (json['credits'] != null &&
        json['credits']['cast'] != null) {
      castList = (json['credits']['cast'] as List)
          .map((person) => Cast.fromJson(person))
          .toList();
    }

    // Get genres
    List<String> genresList = [];

    if (json['genres'] != null) {
      genresList = (json['genres'] as List)
          .map((genre) => genre['name'].toString())
          .toList();
    }

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: genresList,
      cast: castList,
    );
  }
}

class Cast {
  final String name;
  final String character;
  final String profilePath;

  Cast({
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }
}