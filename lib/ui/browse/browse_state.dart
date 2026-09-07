import 'package:greduation_movies_fluter/features/home/data/movie_model.dart';


abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<String> genres;
  final List<MovieModel> movies;
  final String selectedGenre;

  BrowseSuccessState({
    required this.genres,
    required this.movies,
    required this.selectedGenre,
  });
}

class BrowseErrorState extends BrowseState {
  final String errorMessage;
  BrowseErrorState(this.errorMessage);
}