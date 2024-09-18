import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kross/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';




class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.signUp(email: event.email, password: event.password);
        emit(AuthSuccess()); // Успех регистрации
      } catch (e) {
        emit(AuthFailure(message: e.toString())); // Отправка сообщения об ошибке
      }
    });
  }





}
