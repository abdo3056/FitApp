part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSaving extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final Map<String, dynamic> data;
  final String uid;
  ProfileLoadSuccess({required this.data, required this.uid});
}

class ProfileSaveSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure({required this.error});
}
