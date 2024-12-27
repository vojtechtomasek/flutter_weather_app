// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CityWeatherScreen]
class CityWeatherRoute extends PageRouteInfo<CityWeatherRouteArgs> {
  CityWeatherRoute({
    Key? key,
    required CityWeatherModel city,
    List<PageRouteInfo>? children,
  }) : super(
          CityWeatherRoute.name,
          args: CityWeatherRouteArgs(
            key: key,
            city: city,
          ),
          initialChildren: children,
        );

  static const String name = 'CityWeatherRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CityWeatherRouteArgs>();
      return CityWeatherScreen(
        key: args.key,
        city: args.city,
      );
    },
  );
}

class CityWeatherRouteArgs {
  const CityWeatherRouteArgs({
    this.key,
    required this.city,
  });

  final Key? key;

  final CityWeatherModel city;

  @override
  String toString() {
    return 'CityWeatherRouteArgs{key: $key, city: $city}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [InputScreen]
class InputRoute extends PageRouteInfo<void> {
  const InputRoute({List<PageRouteInfo>? children})
      : super(
          InputRoute.name,
          initialChildren: children,
        );

  static const String name = 'InputRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InputScreen();
    },
  );
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MapScreen();
    },
  );
}
