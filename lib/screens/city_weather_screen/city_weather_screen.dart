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
      
      final weather = await ApiService.fetchWeatherData(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text(cityData.name, style: const TextStyle(fontSize: 32)),
                    Text(
                      weatherData?.temp != null ? '${weatherData?.temp?.round()}°' : 'N/A',
                      style: const TextStyle(fontSize: 48),
                      ),
                    Text(weatherData?.weatherDescription ?? 'N/A'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_downward),
                        Text(weatherData?.tempMin != null ? '${weatherData?.tempMin?.round()}°' : 'N/A'),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_upward),
                        Text(weatherData?.tempMax != null ? '${weatherData?.tempMax?.round()}°' : 'N/A'),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Card(
                      
                    )
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
                      context.router.push(const MapRoute());
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
      ),
    );
  }
}