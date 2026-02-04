import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeMode themeMode;

  const SetTheme(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

// States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  const ThemeLoaded({
    required this.themeMode,
    required this.isDarkMode,
  });

  @override
  List<Object?> get props => [themeMode, isDarkMode];

  ThemeLoaded copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
  }) {
    return ThemeLoaded(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class ThemeError extends ThemeState {
  final String message;

  const ThemeError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeMode = prefs.getString('theme_mode') ?? 'dark';
      
      final themeMode = savedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      final isDarkMode = themeMode == ThemeMode.dark;
      
      emit(ThemeLoaded(themeMode: themeMode, isDarkMode: isDarkMode));
    } catch (e) {
      emit(ThemeError(e.toString()));
    }
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    if (state is ThemeLoaded) {
      final currentState = state as ThemeLoaded;
      final newThemeMode = currentState.isDarkMode ? ThemeMode.light : ThemeMode.dark;
      final newIsDarkMode = !currentState.isDarkMode;
      
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('theme_mode', newIsDarkMode ? 'dark' : 'light');
        
        emit(ThemeLoaded(themeMode: newThemeMode, isDarkMode: newIsDarkMode));
      } catch (e) {
        emit(ThemeError(e.toString()));
      }
    }
  }

  Future<void> _onSetTheme(SetTheme event, Emitter<ThemeState> emit) async {
    try {
      final isDarkMode = event.themeMode == ThemeMode.dark;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme_mode', isDarkMode ? 'dark' : 'light');
      
      emit(ThemeLoaded(themeMode: event.themeMode, isDarkMode: isDarkMode));
    } catch (e) {
      emit(ThemeError(e.toString()));
    }
  }
} 