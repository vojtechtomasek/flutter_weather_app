import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/city_forecast_hourly_model.dart';
import 'package:weather/models/city_history_model.dart';
import '../models/city_weather_model.dart';
import 'package:weather/models/city_forecast_daily_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<CityWeatherModel?> fetchWeatherData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = dotenv.env['OPENWEATHER_BASE_URL'];
    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        return CityWeatherModel.fromJson(data, lat, lon);
      } catch (e) {
        print('Error parsing weather data: $e');
        return null;
      }
    }
    return null; 
  }

  static Future<List<CityForecastHourlyModel>?> fetchForecastHourlyData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = dotenv.env['OPENWEATHER_FORECAST_HOURLY_URL'];
    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        final List forecastList = data['list'];
        return forecastList.map((forecastData) => CityForecastHourlyModel.fromJson(forecastData)).toList();
      } catch (e) {
        print('Error parsing forecast data: $e');
        return null;
      }
    }
    return null;
  }

  static Future<List<CityForecastDailyModel>?> fetchForecastDailyData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = dotenv.env['OPENWEATHER_FORECAST_DAILY_URL'];
    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        final List forecastList = data['list'] ?? [];
        return forecastList.map<CityForecastDailyModel>((forecastData) => CityForecastDailyModel.fromJson(forecastData)).toList();
      } catch (e) {
        print('Error parsing forecast data: $e');
        return null;
      }
    }
    return null;
  }

  static Future<List<CityHistoryModel>?> fetchHistoryData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = dotenv.env['OPENWEATHER_HISTORY_URL'];

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/ 1000;

    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&type=hour&start=$startOfDay&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        final List historyList = data['list'];
        return historyList.map<CityHistoryModel>((historyData) => CityHistoryModel.fromJson(historyData)).toList();
      } catch (e) {
        print('Error parsing history data: $e');
        return null;
      }
    }
    return null;
  }

  static Future<(double, double)?> getCityWithCoordinates(String cityName) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = "http://api.openweathermap.org/geo/1.0";
    final String apiUrl = '$baseUrl/direct?q=$cityName&limit=1&appid=$apiKey';
    
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return (
          data[0]['lat'] as double,
          data[0]['lon'] as double,
        );
      }
    }
    return null;
  }
}