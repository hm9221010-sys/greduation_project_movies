import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/api_manager.dart';

class MovieDetails extends StatefulWidget {
  final dynamic movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetails> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  late Future<dynamic> movieDetailsFuture;

  @override
  void initState() {
    super.initState();
    // تحويل الـ ID لـ int للتأكد من أمان النوع
    int movieId = widget.movie is Map ? (widget.movie['id'] ?? 0) : widget.movie.id;
    movieDetailsFuture = ApiManager.getMovieDetails(movieId);
  }

  @override
  Widget build(BuildContext context) {
    String movieTitle = widget.movie is Map ? (widget.movie['title'] ?? '') : widget.movie.title;

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(movieTitle, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<dynamic>(
        future: movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFBB3B)));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No movie details found', style: TextStyle(color: Colors.white)),
            );
          }

          final movieData = snapshot.data;
          List castList = movieData['cast'] ?? [];
          List genresList = movieData['genres'] ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movieData['large_cover_image'] ?? movieData['medium_cover_image'] ?? '',
                      width: double.infinity,
                      height: 450,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 450,
                        color: Colors.grey.shade800,
                        child: const Icon(Icons.broken_image, color: Colors.white, size: 50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    movieData['title'] ?? '',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),

                  const SizedBox(height: 10),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFBB3B)),
                      const SizedBox(width: 5),
                      Text(
                        '${movieData['rating'] ?? 0.0}',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Summary
                  const Text('Summary', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(
                    (movieData['description_full'] != null && movieData['description_full'].toString().isNotEmpty)
                        ? movieData['description_full']
                        : (movieData['summary'] ?? 'No summary available.'),
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  // Cast
                  const Text('Cast', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 15),

                  if (castList.isEmpty)
                    const Text('No cast information available.', style: TextStyle(color: Colors.grey))
                  else
                    Column(
                      children: castList.take(10).map((person) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipOval(
                                child: (person['url_small_image'] != null && person['url_small_image'].toString().isNotEmpty)
                                    ? Image.network(
                                        person['url_small_image'],
                                        width: 65,
                                        height: 65,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          width: 65,
                                          height: 65,
                                          color: Colors.grey.shade700,
                                          child: const Icon(Icons.person, color: Colors.white),
                                        ),
                                      )
                                    : Container(
                                        width: 65,
                                        height: 65,
                                        color: Colors.grey.shade700,
                                        child: const Icon(Icons.person, color: Colors.white, size: 35),
                                      ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${person['name'] ?? ''}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Character: ${person['character_name'] ?? 'N/A'}',
                                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 25),

                  // Genres
                  const Text('Genres', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: genresList.map((genre) {
                      return Chip(
                        backgroundColor: const Color(0xFF282A28),
                        label: Text(genre.toString(), style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}