import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/movie_model.dart';
import '../../../home/data/services/api_service.dart';
import '../../../home/presentation/widgets/movie_card.dart';

class GenreMoviesView extends StatefulWidget {
  final String genre;

  const GenreMoviesView({
    super.key,
    required this.genre,
  });

  @override
  State<GenreMoviesView> createState() =>
      _GenreMoviesViewState();
}

class _GenreMoviesViewState extends State<GenreMoviesView> {
  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();

    moviesFuture = ApiService().getMoviesByGenre(
      widget.genre,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121312),
        foregroundColor: Colors.white,
        title: Text(
          widget.genre,
        ),
      ),
      body: FutureBuilder<List<MovieModel>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'No movies found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(
              16.w,
            ),
            itemCount: movies.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
              );
            },
          );
        },
      ),
    );
  }
}