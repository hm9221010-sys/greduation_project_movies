import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/constants.dart';
import 'package:greduation_movies_fluter/movie_dart.dart';
import 'package:greduation_movies_fluter/movies_details.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movie: movie,
            ),
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),

        child: Stack(
          children: [

            Positioned.fill(
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                '${AppConstants.imageBaseUrl}${movie.posterPath}',
                fit: BoxFit.cover,
              )
                  : Container(
                color: Colors.grey.shade800,
                child: const Icon(
                  Icons.movie,
                  size: 50,
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Text(
                  '⭐ ${movie.voteAverage.toStringAsFixed(1)}',

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}