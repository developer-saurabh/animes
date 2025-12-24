import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final response = await repository.fetchTopMovies();
      emit(HomeLoaded(response.data));
    } catch (e) {
      emit(HomeError('Failed to load data'));
    }
  }
}
