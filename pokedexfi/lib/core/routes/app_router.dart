import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedexfi/pages/details/args/poke_details_args.dart';
import 'package:pokedexfi/pages/pokes_list/pokes_list_page.dart';

import '../../pages/error_page.dart';
import '../../pages/details/poke_details_page.dart';

enum Routes {
  listPage,
  detailsPage,
  errorPage,
}

Map<String, WidgetBuilder> routes = {
  '/': (context) => routes[Routes.listPage.route]!(context),
  Routes.listPage.route: (context) => const PokesListPage(),
  Routes.detailsPage.route: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as PokeDetailsArgs;

    return PokeDetailsPage(args);
  },
  Routes.errorPage.route: (context) => const ErrorPage(),
};

extension RoutesX on Routes {
  String get route => toString();
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        try {
          if (routes.containsKey(settings.name)) {
            return routes[settings.name]!(context);
          }
          return routes[Routes.errorPage.route]!(context);
        } catch (e) {
          log('Error $e');
          return routes[Routes.errorPage.route]!(context);
        }
      },
    );
  }
}
