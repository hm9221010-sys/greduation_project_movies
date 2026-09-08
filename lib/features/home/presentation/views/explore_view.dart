import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greduation_movies_fluter/l10n/app_localizations.dart';

import '../../../home/data/movie_model.dart';
import '../../../home/data/services/api_service.dart';
import '../../../home/presentation/manager/home_bloc.dart';
import '../../../home/presentation/widgets/movie_card.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({
    super.key,
  });

  @override
  State<ExploreView> createState() =>
      _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  String selectedGenre = 'Action';

  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();

    moviesFuture = ApiService().getMoviesByGenre(
      selectedGenre,
    );
  }

  void changeGenre(String genre) {
    setState(() {
      selectedGenre = genre;

      moviesFuture = ApiService().getMoviesByGenre(
        selectedGenre,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 18.h,
            ),

            //todo Genres
            SizedBox(
              height: 48.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: HomeBloc.categories.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
                itemBuilder: (context, index) {
                  final genre =
                  HomeBloc.categories[index];

                  final isSelected =
                      selectedGenre == genre;

                  return GestureDetector(
                    onTap: () {
                      changeGenre(genre);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.amber
                            : Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(
                          14.r,
                        ),
                        border: Border.all(
                          color: Colors.amber,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : Colors.amber,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 18.h,
            ),

            //todo Movies
            Expanded(
              child: FutureBuilder<List<MovieModel>>(
                future: moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child:
                      CircularProgressIndicator(
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

                  final movies =
                      snapshot.data ?? [];

                  if (movies.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noMoviesFound,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.only(
                      bottom: 100.h,
                    ),
                    itemCount: movies.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
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
            ),
          ],
        ),
      ),
    );
  }
}