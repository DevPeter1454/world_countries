import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_countries/provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
   return IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
          ),
          onPressed: () {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme();
            // themeProvider.toggleTheme();
          },
        );
  }
}
