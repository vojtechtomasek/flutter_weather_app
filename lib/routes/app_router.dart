import 'package:auto_route/auto_route.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/input_screen.dart';
import '../screens/city_weather_screen/city_weather_screen.dart';
import '../screens/map_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: InputRoute.page),
    AutoRoute(page: CityWeatherRoute.page),
    AutoRoute(page: MapRoute.page),
  ];
}