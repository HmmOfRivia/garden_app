import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/config/injection.dart';
import 'package:garden_app/config/routes.gr.dart';
import 'package:garden_app/generated/l10n.dart';

class GardenApp extends StatelessWidget {
  const GardenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    return MaterialApp.router(
      theme: AppThemeData.lightAppTheme,
      localizationsDelegates: const [S.delegate],
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );
  }
}
