import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/blocs/theme/theme_bloc.dart';
import 'core/blocs/language/language_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(LoadTheme()),
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc()..add(LoadLanguage()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp.router(
                title: 'Flutter Bloc Boilerplate',
                debugShowCheckedModeBanner: false,

                // Theme configuration
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState is ThemeLoaded
                    ? themeState.themeMode
                    : ThemeMode.system,

                // Localization configuration
                locale: languageState is LanguageLoaded
                    ? languageState.currentLocale
                    : const Locale('en', 'US'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,

                // Router configuration
                routerConfig: AppRouter.router,

                // RTL support
                builder: (context, child) {
                  return Directionality(
                    textDirection: languageState is LanguageLoaded
                        ? languageState.getTextDirection()
                        : TextDirection.ltr,
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
