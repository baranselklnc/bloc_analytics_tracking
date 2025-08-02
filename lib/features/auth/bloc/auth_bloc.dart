import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginPressed(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpPressed extends AuthEvent {
  final String email;
  final String password;

  const SignUpPressed(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LogoutPressed extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userId;

  const AuthSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginPressed>(_onLoginPressed);
    on<SignUpPressed>(_onSignUpPressed);
    on<LogoutPressed>(_onLogoutPressed);
  }

  Future<void> _onLoginPressed(
    LoginPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simüle edilmiş login işlemi
      await Future.delayed(const Duration(seconds: 1));
      
      if (event.email == 'test@example.com' && event.password == 'password') {
        emit(const AuthSuccess('user_123'));
      } else {
        emit(const AuthFailure('Geçersiz email veya şifre'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUpPressed(
    SignUpPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simüle edilmiş signup işlemi
      await Future.delayed(const Duration(seconds: 1));
      
      if (event.email.isNotEmpty && event.password.length >= 6) {
        emit(const AuthSuccess('new_user_456'));
      } else {
        emit(const AuthFailure('Geçersiz bilgiler'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutPressed(
    LogoutPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simüle edilmiş logout işlemi
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
} 