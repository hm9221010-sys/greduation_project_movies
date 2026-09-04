import '../../data/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> movies;
  HomeLoaded(this.movies);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}