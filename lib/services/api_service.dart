import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/city_forecast_model.dart';
import '../models/city_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<City?> fetchWeatherData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = "http://api.openweathermap.org/data/2.5/weather";
    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        return City(
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
          rain: (data['rain']?['1h'] as num?)?.toDouble(),
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

  static Future<List<CityForecast>?> fetchForecastData(double lat, double lon) async {
    String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = dotenv.env['OPENWEATHER_FORECAST_URL'];
    final String apiUrl = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        final List forecastList = data['list'];
        return forecastList.map((forecastData) => CityForecast(
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
        )).toList();
      } catch (e) {
        print('Error parsing forecast data: $e');
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