import 'package:flutter/material.dart';
import 'package:world_countries/view/DetailsScreen/detail_screen.dart';
import 'package:world_countries/view/HomeScreen/home_screen.dart';

import 'models/country/country_model.dart';

class OnGenerateRoute {
  static onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case DetailsScreen.routeName:
        var country = settings.arguments as Country;
        return MaterialPageRoute(builder: (context) => DetailsScreen(country: country,));
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
