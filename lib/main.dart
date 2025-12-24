import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/color_constants.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AnimeHubApp());
}

class AnimeHubApp extends StatelessWidget {
  const AnimeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        useMaterial3: true,
      ),
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
