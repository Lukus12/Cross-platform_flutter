import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/di/di.dart';
import 'package:kross/domain/domain.dart';
part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final KrossRepository krossRepository;
  HomeBloc(this.krossRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }
  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    // Если данные уже загружены, не выполняем новый запрос
    if (state is HomeLoadSuccess) {
      return; // Завешаем выполнение, если данные уже загружены
    }

    // Показать индикатор загрузки
    emit(HomeLoadInProgress());

    try {
      final articles = await krossRepository.getFactsAboutSpace();
      emit(HomeLoadSuccess(articles: articles));
    } catch (exception) {
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception); // Обработка исключений
    } finally {
      event.completer?.complete();
    }
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}