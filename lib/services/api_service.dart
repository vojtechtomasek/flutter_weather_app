import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city_model.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<City?> fetchData(double lat, double lon) async {
    String? apiKey = "";  // dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = "http://api.openweathermap.org/data/2.5/weather"; // Changed to weather endpoint
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
          lat: lat,
          lon: lon,
          country: data['sys']['country'] as String,
        );
      } catch (e) {
        print('Error parsing weather data: $e');
        return null;
      }
    }
    return null; 
  }

  static Future<City?> getCityWithCoordinates(String cityName) async {
    String? apiKey = ""; // dotenv.env['OPENWEATHER_API_KEY'];
    String? baseUrl = "http://api.openweathermap.org/geo/1.0"; // dotenv.env['OPENWEATHER_GEOCODING_URL'];
    final String url = '$baseUrl/direct?q=$cityName&limit=1&appid=$apiKey';
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        return City(
          name: cityName,
          lat: data[0]['lat'],
          lon: data[0]['lon'],
          country: data[0]['country'],
        );
      }
    }
    return null;
  }
}