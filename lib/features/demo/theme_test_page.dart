import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_boilerplate/core/blocs/theme/theme_bloc.dart';

class ThemeTestPage extends StatelessWidget {
  const ThemeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Theme Test'),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/dark_bg.png'
                  : 'assets/images/light_bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
