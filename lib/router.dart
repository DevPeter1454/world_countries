import 'package:flutter/material.dart';
import 'package:world_countries/view/DetailsScreen/detail_screen.dart';

import 'models/country/country_model.dart';

class onGenerateRoute {
  static onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case DetailsScreen.routeName:
        var country = settings.arguments as Country;
        return MaterialPageRoute(builder: (context) => DetailsScreen(country: country,));

      default:
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
