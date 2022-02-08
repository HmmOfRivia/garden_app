// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i4;

import '../presentation/plants_form_page/plants_form_page.dart' as _i3;
import '../presentation/plants_page/plants_page.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    PlantsRoute.name: (routeData) {
      return _i1.MaterialPageX<_i4.Widget>(
          routeData: routeData, child: const _i2.PlantsPage());
    },
    PlantsFormRoute.name: (routeData) {
      final args = routeData.argsAs<PlantsFormRouteArgs>(
          orElse: () => const PlantsFormRouteArgs());
      return _i1.CustomPage<_i4.Widget>(
          routeData: routeData,
          child: _i3.PlantsFormPage(key: args.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainRouter.name, path: '/', children: [
          _i1.RouteConfig(PlantsRoute.name, path: '', parent: MainRouter.name),
          _i1.RouteConfig(PlantsFormRoute.name,
              path: ':id', parent: MainRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class MainRouter extends _i1.PageRouteInfo<void> {
  const MainRouter({List<_i1.PageRouteInfo>? children})
      : super(MainRouter.name, path: '/', initialChildren: children);

  static const String name = 'MainRouter';
}

/// generated route for
/// [_i2.PlantsPage]
class PlantsRoute extends _i1.PageRouteInfo<void> {
  const PlantsRoute() : super(PlantsRoute.name, path: '');

  static const String name = 'PlantsRoute';
}

/// generated route for
/// [_i3.PlantsFormPage]
class PlantsFormRoute extends _i1.PageRouteInfo<PlantsFormRouteArgs> {
  PlantsFormRoute({_i4.Key? key})
      : super(PlantsFormRoute.name,
            path: ':id', args: PlantsFormRouteArgs(key: key));

  static const String name = 'PlantsFormRoute';
}

class PlantsFormRouteArgs {
  const PlantsFormRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'PlantsFormRouteArgs{key: $key}';
  }
}
