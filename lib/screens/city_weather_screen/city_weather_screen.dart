import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/routes/app_router.dart';
import '../../models/city_model.dart';
import '../../services/api_service.dart';

@RoutePage()
class CityWeatherScreen extends StatefulWidget {
  final City city;

  const CityWeatherScreen({super.key, required this.city});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  late City cityData;
  City? weatherData;

  @override
  void initState() {
    super.initState();
    cityData = widget.city;
    _loadCityData();
  }

  Future<void> _loadCityData() async {
    final updatedCity = await ApiService.getCityWithCoordinates(widget.city.name);
    if (updatedCity != null) {
      setState(() {
        cityData = updatedCity;
      });
      
      final weather = await ApiService.fetchData(
        cityData.lat ?? 0,
        cityData.lon ?? 0
      );
      if (weather != null) {
        setState(() {
          weatherData = weather;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cityData.name),
                  Text(cityData.lat?.toString() ?? ''),
                  Text(cityData.lon?.toString() ?? ''),
                  Text(cityData.country ?? ''),
                  if (weatherData != null) ...[
                    Text('Temperature: ${weatherData?.temp}°C'),
                    Text('Feels like: ${weatherData?.feelsLike}°C'),
                    Text('Humidity: ${weatherData?.humidity}%'),
                    Text('Description: ${weatherData?.weatherDescription}'),
                  ],
                ],
              ) 
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: const Icon(Icons.map, color: Colors.black),
                  onPressed: () {
                    // Map button action
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    context.router.replaceAll([const HomeRoute()]);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}