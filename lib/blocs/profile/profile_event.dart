part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoaded extends ProfileEvent {}

class ProfileUpdated extends ProfileEvent {
  final Map<String, dynamic> data;
  final File? avatarFile;
  ProfileUpdated({required this.data, this.avatarFile});
}

class ProfilePasswordChanged extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  ProfilePasswordChanged({required this.oldPassword, required this.newPassword});
}
