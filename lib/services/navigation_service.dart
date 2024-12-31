import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/routes/app_router.dart';
import 'package:weather/services/api_service.dart';

class NavigationService {
  static Future<void> fetchAndNavigate(BuildContext context, String cityName) async {
    final coordinates = await ApiService.getCityWithCoordinates(cityName);
    if (coordinates != null) {
      final (lat, lon) = coordinates;
      final cityWeather = await ApiService.fetchWeatherData(lat, lon);
      if (cityWeather != null) {
        CityWeatherModel.addCity(cityWeather);
        if (context.mounted) {
          context.router.push(CityWeatherRoute(city: cityWeather));
        }
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch weather data')),
        );
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City not found')),
      );
    }
  }
}