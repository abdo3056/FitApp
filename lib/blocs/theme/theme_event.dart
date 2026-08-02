part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ThemeLoaded extends ThemeEvent {}

class ThemeToggled extends ThemeEvent {
  final bool isDark;
  ThemeToggled(this.isDark);
}
