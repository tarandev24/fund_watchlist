part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String mobileNumber;
  final Map<String, dynamic> data;

  const SignUpRequested(
      this.email, this.password, this.mobileNumber, this.data);
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}

class AuthStatusChanged extends AuthEvent {
  final Session? session;

  const AuthStatusChanged(this.session);
}
