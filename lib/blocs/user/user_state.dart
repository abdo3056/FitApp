part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> data;
  UserLoaded({required this.data});
}

class UserUpdateSuccess extends UserState {}

class UserPasswordChanged extends UserState {}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}
