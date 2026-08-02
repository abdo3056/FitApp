import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/services/auth_service.dart';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService _authService = AuthService();

  UserBloc() : super(UserInitial()) {
    on<UserLoad>(_onLoad);
    on<UserUpdateProfile>(_onUpdateProfile);
    on<UserChangePassword>(_onChangePassword);
  }

  Future<void> _onLoad(UserLoad event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = _authService.currentUser;
      if (user == null) {
        emit(UserError(message: 'Not logged in'));
        return;
      }
      final doc = await FirestoreService().getUserData(user.uid);
      final data = doc.data() ?? {};
      emit(UserLoaded(data: data));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UserUpdateProfile event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = _authService.currentUser;
      if (user == null) {
        emit(UserError(message: 'Not logged in'));
        return;
      }
      await FirestoreService().saveUserData(
        uid: user.uid,
        data: {
          'username': event.username,
          'email': event.email,
          'height': event.height,
          'weight': event.weight,
          if (event.photoUrl != null) 'photoUrl': event.photoUrl,
        },
      );
      final doc = await FirestoreService().getUserData(user.uid);
      emit(UserLoaded(data: doc.data() ?? {}));
      emit(UserUpdateSuccess());
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> _onChangePassword(
      UserChangePassword event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = _authService.currentUser;
      if (user == null || user.email == null) {
        emit(UserError(message: 'Not logged in'));
        return;
      }

      // Re-authenticate to verify old password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: event.oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(event.newPassword);

      emit(UserPasswordChanged());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        emit(UserError(message: 'Old password is incorrect.'));
      } else {
        emit(UserError(message: e.message ?? 'Password change failed.'));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
