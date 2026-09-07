import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greduation_movies_fluter/api_manager.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  List<String> categories = [];

  BrowseCubit() : super(BrowseInitialState());

  Future<void> loadBrowseData() async {
    emit(BrowseLoadingState());
    try {
      var allMovies = await ApiManager.getMovies();

      Set<String> genreSet = {};
      for (var movie in allMovies) {
        genreSet.addAll(movie.genres);
      }

      categories = genreSet.toList();
      String initialGenre = categories.isNotEmpty ? categories.first : 'Action';

      var genreMovies = await ApiManager.getMovies(genre: initialGenre);

      emit(BrowseSuccessState(
        genres: categories,
        movies: genreMovies,
        selectedGenre: initialGenre,
      ));
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }

  Future<void> changeCategory(String selectedGenre) async {
    try {
      emit(BrowseLoadingState());
      var movies = await ApiManager.getMovies(genre: selectedGenre);
      emit(BrowseSuccessState(
        genres: categories,
        movies: movies,
        selectedGenre: selectedGenre,
      ));
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }
}