import 'package:anime/app%20screens/anime_detail/presentation/anime_detail_page.dart';
import 'package:anime/app%20screens/home/data/models/anime_model.dart';
import 'package:anime/app%20screens/home/presentation/home_page.dart';
import 'package:anime/app%20screens/home/presentation/search_page.dart';
import 'package:anime/app%20screens/new_releases/presentation/new_releases_page.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case RouteNames.search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
        );

      case RouteNames.newReleases:
        return MaterialPageRoute(
          builder: (_) => const NewReleasesPage(),
        );

     case RouteNames.animeDetail:
  final anime = settings.arguments as AnimeModel;

  return MaterialPageRoute(
    builder: (_) => AnimeDetailPage(anime: anime),
  );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Route not found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}
