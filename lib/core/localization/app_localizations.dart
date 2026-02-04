import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations/en.dart';
import 'translations/ar.dart';
import 'translations/he.dart';
import 'translations/fa.dart';
import 'translations/ur.dart';
import 'translations/es.dart';
import 'translations/fr.dart';
import 'translations/de.dart';
import 'translations/hi.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'SA'),
    Locale('he', 'IL'),
    Locale('fa', 'IR'),
    Locale('ur', 'PK'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('hi', 'IN'),
  ];
  
  // Get translations based on locale
  Map<String, String> get translations {
    switch (locale.languageCode) {
      case 'ar':
        return ar;
      case 'he':
        return he;
      case 'fa':
        return fa;
      case 'ur':
        return ur;
      case 'es':
        return es;
      case 'fr':
        return fr;
      case 'de':
        return de;
      case 'hi':
        return hi;
      default:
        return en;
    }
  }
  
  // Get text direction
  TextDirection get textDirection {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(locale.languageCode) 
        ? TextDirection.rtl 
        : TextDirection.ltr;
  }
  
  // Check if current locale is RTL
  bool get isRTL => textDirection == TextDirection.rtl;
  
  // Get alignment for current locale
  Alignment get alignment => isRTL ? Alignment.centerRight : Alignment.centerLeft;
  
  // Get cross alignment for current locale
  CrossAxisAlignment get crossAxisAlignment => isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  
  // Get main alignment for current locale
  MainAxisAlignment get mainAxisAlignment => isRTL ? MainAxisAlignment.end : MainAxisAlignment.start;
  
  // Get text alignment for current locale
  TextAlign get textAlign => isRTL ? TextAlign.right : TextAlign.left;
  
  // Translate text
  String translate(String key) {
    return translations[key] ?? key;
  }
  
  // Translate with parameters
  String translateWithParams(String key, Map<String, String> params) {
    String text = translate(key);
    params.forEach((param, value) {
      text = text.replaceAll('{$param}', value);
    });
    return text;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Extension for easy access to translations
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  
  String tr(String key) => l10n.translate(key);
  
  String trParams(String key, Map<String, String> params) => l10n.translateWithParams(key, params);
  
  bool get isRTL => l10n.isRTL;
  
  TextDirection get textDirection => l10n.textDirection;
  
  Alignment get alignment => l10n.alignment;
  
  CrossAxisAlignment get crossAxisAlignment => l10n.crossAxisAlignment;
  
  MainAxisAlignment get mainAxisAlignment => l10n.mainAxisAlignment;
  
  TextAlign get textAlign => l10n.textAlign;
} 