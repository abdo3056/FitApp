import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitapp/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const _loggedInKey = 'isLoggedIn';

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheck);
    on<AuthLoggedOut>(_onLogout);
  }

  Future<void> _onCheck(AuthCheckRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_loggedInKey) ?? false;
    final user = AuthService().currentUser;
    if (isLoggedIn && user != null) {
      emit(AuthAuthenticated(uid: user.uid));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(AuthLoggedOut event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await AuthService().signOut();
    emit(AuthUnauthenticated());
  }

  static Future<void> persistLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
  }
}
