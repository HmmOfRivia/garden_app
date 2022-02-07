import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:garden_app/presentation/plants_form_page/plants_form_page.dart';
import 'package:garden_app/presentation/plants_page/plants_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      path: '/',
      name: 'MainRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<Widget>(
          path: '',
          page: PlantsPage,
        ),
        CustomRoute<Widget>(
          path: ':id',
          page: PlantsFormPage,
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 500,
        )
      ],
    )
  ],
)
class $AppRouter {}
