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
        return CityWeatherModel(
          name: data['name'] ?? '',
          temp: (data['main']['temp'] as num).toDouble(),
          feelsLike: (data['main']['feels_like'] as num).toDouble(),
          tempMin: (data['main']['temp_min'] as num).toDouble(),
          tempMax: (data['main']['temp_max'] as num).toDouble(),
          pressure: (data['main']['pressure'] as num).toInt(),
          humidity: (data['main']['humidity'] as num).toInt(),
          weatherDescription: data['weather'][0]['description'] as String,
          windSpeed: (data['wind']['speed'] as num).toDouble(),
          windDeg: (data['wind']?['deg'] as num?)?.toInt(),
          windGust: (data['wind']?['gust'] as num?)?.toDouble(),
          lat: lat,
          lon: lon,
          country: data['sys']['country'] as String,
          sunRise: data['sys']['sunrise'] as int,
          sunSet: data['sys']['sunset'] as int,
          rain: (data['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
          clouds: (data['clouds']?['all'] as num?)?.toInt(),
          visibility: (data['visibility'] as num?)?.toInt(),
        );
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
        return forecastList.map((forecastData) => CityForecastHourlyModel(
          dt: forecastData['dt'],
          dtTxt: forecastData['dt_txt'],
          temp: (forecastData['main']['temp'] as num).toDouble(),
          feelsLike: (forecastData['main']['feels_like'] as num).toDouble(),
          tempMin: (forecastData['main']['temp_min'] as num).toDouble(),
          tempMax: (forecastData['main']['temp_max'] as num).toDouble(),
          pressure: (forecastData['main']['pressure'] as num).toInt(),
          humidity: (forecastData['main']['humidity'] as num).toInt(),
          weatherDescription: forecastData['weather'][0]['description'],
          windSpeed: (forecastData['wind']['speed'] as num).toDouble(),
          visibility: (forecastData['visibility'] as num).toInt(),
          clouds: (forecastData['clouds']['all'] as num).toInt(),
          rain: (forecastData['rain']?['3h'] as num?)?.toDouble() ?? 0.0,
        )).toList();
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
        return forecastList.map<CityForecastDailyModel>((forecastData) => CityForecastDailyModel(
          dt: forecastData['dt'],
          sunrise: forecastData['sunrise'],
          sunset: forecastData['sunset'],
          dayTemp: (forecastData['temp']['day'] as num).toDouble(),
          minTemp: (forecastData['temp']['min'] as num).toDouble(),
          maxTemp: (forecastData['temp']['max'] as num).toDouble(),
          nightTemp: (forecastData['temp']['night'] as num).toDouble(),
          eveTemp: (forecastData['temp']['eve'] as num).toDouble(),
          mornTemp: (forecastData['temp']['morn'] as num).toDouble(),
          dayFeelsLike: (forecastData['feels_like']['day'] as num).toDouble(),
          nightFeelsLike: (forecastData['feels_like']['night'] as num).toDouble(),
          eveFeelsLike: (forecastData['feels_like']['eve'] as num).toDouble(),
          mornFeelsLike: (forecastData['feels_like']['morn'] as num).toDouble(),
          pressure: (forecastData['pressure'] as num).toInt(),
          humidity: (forecastData['humidity'] as num).toInt(),
          weatherDescription: forecastData['weather'][0]['description'],
          windSpeed: (forecastData['speed'] as num).toDouble(),
          windDeg: (forecastData['deg'] as num).toInt(),
          windGust: (forecastData['gust'] as num).toDouble(),
          clouds: (forecastData['clouds'] as num).toInt(),
          pop: (forecastData['pop'] as num).toDouble(),
          rain: (forecastData['rain'] as num?)?.toDouble() ?? 0.0,
        )).toList();
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
        return historyList.map<CityHistoryModel>((historyData) => CityHistoryModel(
          dt: historyData['dt'],
          temp: (historyData['main']['temp'] as num).toDouble(),
          feelsLike: (historyData['main']['feels_like'] as num).toDouble(),
          pressure: (historyData['main']['pressure'] as num).toInt(),
          humidity: (historyData['main']['humidity'] as num).toInt(),
          clouds: (historyData['clouds']['all'] as num).toInt(),
          rain: (historyData['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
        )).toList();
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