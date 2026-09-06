import '../../data/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> movies;
  final List<MovieModel> categoryMovies;
  final String categoryName;
  final bool categoryLoading;

  HomeLoaded(
      this.movies,
      this.categoryMovies,
      this.categoryName, {
        this.categoryLoading = false,
      });

  HomeLoaded copyWith({
    List<MovieModel>? movies,
    List<MovieModel>? categoryMovies,
    String? categoryName,
    bool? categoryLoading,
  }) {
    return HomeLoaded(
      movies ?? this.movies,
      categoryMovies ?? this.categoryMovies,
      categoryName ?? this.categoryName,
      categoryLoading: categoryLoading ?? this.categoryLoading,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}