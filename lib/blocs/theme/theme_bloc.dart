import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const _key = 'isDarkMode';

  ThemeBloc() : super(const ThemeState(isDark: false)) {
    on<ThemeToggled>(_onToggle);
    on<ThemeLoaded>(_onLoad);
  }

  Future<void> _onLoad(ThemeLoaded event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? false;
    emit(ThemeState(isDark: isDark));
  }

  Future<void> _onToggle(ThemeToggled event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, event.isDark);
    emit(ThemeState(isDark: event.isDark));
  }
}
