import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class LoadLanguage extends LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;
  final String countryCode;

  const ChangeLanguage({
    required this.languageCode,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [languageCode, countryCode];
}

class ChangeLanguageByLocale extends LanguageEvent {
  final Locale locale;

  const ChangeLanguageByLocale(this.locale);

  @override
  List<Object?> get props => [locale];
}

class ToggleLanguage extends LanguageEvent {}

// States
abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final Locale currentLocale;
  final List<Locale> supportedLocales;

  const LanguageLoaded({
    required this.currentLocale,
    required this.supportedLocales,
  });

  @override
  List<Object?> get props => [currentLocale, supportedLocales];

  LanguageLoaded copyWith({
    Locale? currentLocale,
    List<Locale>? supportedLocales,
  }) {
    return LanguageLoaded(
      currentLocale: currentLocale ?? this.currentLocale,
      supportedLocales: supportedLocales ?? this.supportedLocales,
    );
  }

  String getCurrentLanguageName() {
    switch (currentLocale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'hi':
        return 'हिंदी';
      case 'ar':
        return 'العربية';
      case 'he':
        return 'עברית';
      case 'fa':
        return 'فارسی';
      case 'ur':
        return 'اردو';
      default:
        return 'English';
    }
  }

  bool isRTL() {
    // List of RTL language codes
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(currentLocale.languageCode);
  }

  // Get text direction for the current locale
  TextDirection getTextDirection() {
    return isRTL() ? TextDirection.rtl : TextDirection.ltr;
  }

  // Get alignment for the current locale
  Alignment getAlignment() {
    return isRTL() ? Alignment.centerRight : Alignment.centerLeft;
  }

  // Get cross alignment for the current locale
  CrossAxisAlignment getCrossAxisAlignment() {
    return isRTL() ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  // Get main alignment for the current locale
  MainAxisAlignment getMainAxisAlignment() {
    return isRTL() ? MainAxisAlignment.end : MainAxisAlignment.start;
  }
}

class LanguageError extends LanguageState {
  final String message;

  const LanguageError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ChangeLanguageByLocale>(_onChangeLanguageByLocale);
    on<ToggleLanguage>(_onToggleLanguage);
  }

  Future<void> _onLoadLanguage(LoadLanguage event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    try {
      final supportedLocales = <Locale>[
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
        const Locale('fr', 'FR'),
        const Locale('de', 'DE'),
        const Locale('hi', 'IN'),
        const Locale('ar', 'SA'),
        const Locale('he', 'IL'),
        const Locale('fa', 'IR'),
        const Locale('ur', 'PK'),
      ];

      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString('language_code') ?? 'en';
      final savedCountryCode = prefs.getString('country_code') ?? 'US';
      
      final currentLocale = Locale(savedLanguageCode, savedCountryCode);
      
      emit(LanguageLoaded(
        currentLocale: currentLocale,
        supportedLocales: supportedLocales,
      ));
    } catch (e) {
      emit(LanguageError(e.toString()));
    }
  }

  Future<void> _onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    if (state is LanguageLoaded) {
      final currentState = state as LanguageLoaded;
      final newLocale = Locale(event.languageCode, event.countryCode);
      
      if (currentState.supportedLocales.contains(newLocale)) {
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('language_code', event.languageCode);
          await prefs.setString('country_code', event.countryCode);
          
          emit(currentState.copyWith(currentLocale: newLocale));
        } catch (e) {
          emit(LanguageError(e.toString()));
        }
      }
    }
  }

  Future<void> _onChangeLanguageByLocale(ChangeLanguageByLocale event, Emitter<LanguageState> emit) async {
    if (state is LanguageLoaded) {
      final currentState = state as LanguageLoaded;
      
      if (currentState.supportedLocales.contains(event.locale)) {
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('language_code', event.locale.languageCode);
          await prefs.setString('country_code', event.locale.countryCode ?? '');
          
          emit(currentState.copyWith(currentLocale: event.locale));
        } catch (e) {
          emit(LanguageError(e.toString()));
        }
      }
    }
  }

  Future<void> _onToggleLanguage(ToggleLanguage event, Emitter<LanguageState> emit) async {
    if (state is LanguageLoaded) {
      final currentState = state as LanguageLoaded;
      final currentIndex = currentState.supportedLocales.indexOf(currentState.currentLocale);
      final nextIndex = (currentIndex + 1) % currentState.supportedLocales.length;
      final nextLocale = currentState.supportedLocales[nextIndex];
      
      add(ChangeLanguageByLocale(nextLocale));
    }
  }
} 