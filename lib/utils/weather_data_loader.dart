import 'package:weather/models/city_forecast_daily_model.dart';
import 'package:weather/models/city_forecast_hourly_model.dart';
import 'package:weather/models/city_history_model.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/services/api_service.dart';

Future<Map<String, dynamic>> loadWeatherData(String cityName) async {
  final coordinates = await ApiService.getCityWithCoordinates(cityName);
  if (coordinates != null) {
    final weatherFuture = ApiService.fetchWeatherData(coordinates.$1, coordinates.$2);
    final forecastHourlyFuture = ApiService.fetchForecastHourlyData(coordinates.$1, coordinates.$2);
    final forecastDailyFuture = ApiService.fetchForecastDailyData(coordinates.$1, coordinates.$2);
    final historyFuture = ApiService.fetchHistoryData(coordinates.$1, coordinates.$2);

    final results = await Future.wait([
      weatherFuture,
      forecastHourlyFuture,
      forecastDailyFuture,
      historyFuture,
    ]);

    return {
      'weatherData': results[0] as CityWeatherModel?,
      'forecastHourlyData': results[1] as List<CityForecastHourlyModel>?,
      'forecastDailyData': results[2] as List<CityForecastDailyModel>?,
      'historyData': results[3] as List<CityHistoryModel>?,
    };
  }
  return {};
}