part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoad extends UserEvent {}

class UserUpdateProfile extends UserEvent {
  final String username;
  final String email;
  final double height;
  final double weight;
  final String? photoUrl;

  UserUpdateProfile({
    required this.username,
    required this.email,
    required this.height,
    required this.weight,
    this.photoUrl,
  });
}

class UserChangePassword extends UserEvent {
  final String oldPassword;
  final String newPassword;
  UserChangePassword({required this.oldPassword, required this.newPassword});
}
