part of "inside_the_home_bloc.dart";
sealed class InsideTheHomeState extends Equatable {
  const InsideTheHomeState();
  @override
  List<Object> get props => [];
}
final class InsideHomeInitial extends InsideTheHomeState {}
final class InsideHomeLoadInProgress extends InsideTheHomeState {}
final class InsideHomeLoadSuccess extends InsideTheHomeState {
  const InsideHomeLoadSuccess({
    required this.article,
  });
  final Article article;

  @override
  List<Object> get props => [article];
}
final class InsideHomeLoadFailure extends InsideTheHomeState {
  const InsideHomeLoadFailure({
    required this.exception,
  });
  final Object? exception;
  @override
  List<Object> get props => [];
}