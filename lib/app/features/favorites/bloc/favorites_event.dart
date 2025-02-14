part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class LoadFavorites extends FavoritesEvent {
  @override
  List<Object> get props => [];
}

class ToggleFavorite extends FavoritesEvent {
  final String date;

  const ToggleFavorite(this.date);

  @override
  List<Object> get props => [date];
}