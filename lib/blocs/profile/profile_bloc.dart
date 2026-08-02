import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:fitapp/services/auth_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoaded>(_onLoad);
    on<ProfileUpdated>(_onUpdate);
    on<ProfilePasswordChanged>(_onPasswordChange);
  }

  Future<void> _onLoad(ProfileLoaded event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = AuthService().currentUser;
      if (user == null) return;
      final doc = await FirestoreService().getUserData(user.uid);
      emit(ProfileLoadSuccess(data: doc.data() ?? {}, uid: user.uid));
    } catch (e) {
      emit(ProfileFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdate(ProfileUpdated event, Emitter<ProfileState> emit) async {
    emit(ProfileSaving());
    try {
      final user = AuthService().currentUser;
      if (user == null) return;

      // Update email in Firebase Auth if changed
      if (event.data['email'] != null && event.data['email'] != user.email) {
        await user.verifyBeforeUpdateEmail(event.data['email']);
      }

      await FirestoreService().saveUserData(uid: user.uid, data: event.data);
      emit(ProfileSaveSuccess());
    } catch (e) {
      emit(ProfileFailure(error: e.toString()));
    }
  }

  Future<void> _onPasswordChange(
      ProfilePasswordChanged event, Emitter<ProfileState> emit) async {
    emit(ProfileSaving());
    try {
      final user = AuthService().currentUser;
      if (user == null || user.email == null) return;

      // Re-authenticate with old password
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: event.oldPassword);
      await user.reauthenticateWithCredential(cred);

      // Update password
      await user.updatePassword(event.newPassword);
      emit(ProfileSaveSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ProfileFailure(
          error: e.code == 'wrong-password' || e.code == 'invalid-credential'
              ? 'Old password is incorrect'
              : e.message ?? 'An error occurred'));
    } catch (e) {
      emit(ProfileFailure(error: e.toString()));
    }
  }
}
