import '../../data/models/anime_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<AnimeModel> animeList;

  HomeLoaded(this.animeList);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
