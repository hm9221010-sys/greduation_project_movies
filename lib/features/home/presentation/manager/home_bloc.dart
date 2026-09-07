import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/api_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;

  static const List<String> categories = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
  ];

  static const int _maxPagesPerGenre = 5;

  int _categoryIndex = 0;
  final Map<String, int> _genrePage = {};

  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<NextCategoryEvent>(_onNextCategory);
  }

  Future<void> _onFetchMovies(
      FetchMoviesEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());
    try {
      final movies = await apiService.getMovies();
      movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));

      final firstCategory = categories[_categoryIndex];
      final page = _nextPageFor(firstCategory);
      final categoryMovies =
      await apiService.getMoviesByGenre(firstCategory, page: page);

      emit(HomeLoaded(movies, categoryMovies, firstCategory));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onNextCategory(
      NextCategoryEvent event,
      Emitter<HomeState> emit,
      ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    _categoryIndex = (_categoryIndex + 1) % categories.length;
    final newCategory = categories[_categoryIndex];

    emit(current.copyWith(categoryLoading: true, categoryName: newCategory));

    try {
      final page = _nextPageFor(newCategory);
      final categoryMovies =
      await apiService.getMoviesByGenre(newCategory, page: page);
      emit(current.copyWith(
        categoryMovies: categoryMovies,
        categoryName: newCategory,
        categoryLoading: false,
      ));
    } catch (e) {
      emit(current.copyWith(categoryLoading: false));
    }
  }

  int _nextPageFor(String genre) {
    final current = _genrePage[genre] ?? 0;
    final next = (current % _maxPagesPerGenre) + 1;
    _genrePage[genre] = next;
    return next;
  }
}