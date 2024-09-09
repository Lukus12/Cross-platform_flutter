part of "inside_the_home_bloc.dart";
sealed class InsideTheHouseEvent extends Equatable {
  const InsideTheHouseEvent();
  @override
  List<Object> get props => [];
}
class InsideHomeLoad extends InsideTheHouseEvent {
  const InsideHomeLoad({this.completer});
  final Completer? completer;
  @override
  List<Object> get props => [];
}