part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String uid;
  AuthAuthenticated({required this.uid});
}

class AuthUnauthenticated extends AuthState {}
