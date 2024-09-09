import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/di/di.dart';
import 'package:kross/domain/domain.dart';
part "inside_the_home_event.dart";
part "inside_the_home_state.dart";

class InsideTheHomeBloc extends Bloc<InsideTheHouseEvent, InsideTheHomeState> {
  final InsideFactsAboutSpaceRepository factsAboutSpaceRepository;
  InsideTheHomeBloc(this.factsAboutSpaceRepository) : super(InsideHomeInitial()) {
    on<InsideHomeLoad>(_insideHomeLoad);
  }
  Future<void> _insideHomeLoad(InsideHomeLoad event, Emitter<InsideTheHomeState> emit) async {
    // Если данные уже загружены, не выполняем новый запрос
    if (state is InsideHomeLoadSuccess) {
      return; // Завешаем выполнение, если данные уже загружены
    }

    // Показать индикатор загрузки
    emit(InsideHomeLoadInProgress());

    try {
      final article = await factsAboutSpaceRepository.getFactsAboutSpace();
      emit(InsideHomeLoadSuccess(article: article));
    } catch (exception) {
      emit(InsideHomeLoadFailure(exception: exception));
      talker.handle(exception); // Handle exceptions
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