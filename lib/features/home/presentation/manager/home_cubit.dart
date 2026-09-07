import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());

  void fetchMovies() async {
    emit(HomeLoading());
    try {
      final movies = await apiService.getMovies();

      movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}