import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUp);
    on<SignInRequested>(_onSignIn);
    on<SignOutRequested>(_onSignOut);
    on<AuthStatusChanged>(_onAuthStatusChanged);

    _authRepository.authStateChanges.listen((event) {
      add(AuthStatusChanged(event.session));
    });
  }

  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AuthResponse response =
          await _authRepository.signUp(event.email, event.password, event.data);

      final user = response.user;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignIn(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response =
          await _authRepository.signIn(event.email, event.password);
      final user = response.user;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } on AuthApiException catch (e) {
      print('AuthApiException: ${e.message}');
      emit(AuthError(e.message));
    } catch (e) {
      print('Unexpected error: $e');
      emit(AuthError('An unexpected error occurred.'));
    }
  }

  Future<void> _onSignOut(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.session != null && event.session!.user != null) {
      emit(Authenticated(event.session!.user!));
    } else {
      emit(Unauthenticated());
    }
  }
}
