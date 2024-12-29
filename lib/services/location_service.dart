import 'package:geolocator/geolocator.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/services/api_service.dart';

class LocationService {
  static Future<CityWeatherModel?> getCurrentLocationWeather() async {
    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      final weatherData = await ApiService.fetchWeatherData(
        position.latitude,
        position.longitude,
      );

      return weatherData;
    } catch (e) {
      return null;
    }
  }
}