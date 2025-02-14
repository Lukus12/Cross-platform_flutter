import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kross/domain/domain.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

// bloc
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesBloc(this.favoritesRepository) : super(FavoritesLoading()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
    ) async {
      try {
        print('Начало вызова onLoadFavorites');

        final dates = await favoritesRepository.getFavoriteDates();
        final articles = await favoritesRepository.getFavoriteArticles(dates);
        emit(FavoritesLoaded(articles));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
    ) async {
      try {
        await favoritesRepository.toggleFavorite(event.date);
        add(LoadFavorites());
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
}