import 'package:flutter/material.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/services/location_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:weather/routes/app_router.dart';
import 'widgets/build_city_card.dart';
import 'package:weather/utils/shared_preferences_util.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cityCount = CityWeatherModel.cities.length;
  String currentLocation = 'Your Location';
  bool isFetchingLocation = false;
  CityWeatherModel? currentLocationWeather;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cityCount != CityWeatherModel.cities.length) {
      setState(() {
        _cityCount = CityWeatherModel.cities.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadScreenState();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isFetchingLocation = true;
    });

    final weatherData = await LocationService.getCurrentLocationWeather();

    setState(() {
      if (weatherData != null) {
        currentLocationWeather = weatherData;
        currentLocation = 'Your Location - ${currentLocationWeather?.name}';
      } else {
        currentLocation = 'Failed to get location';
      }
      isFetchingLocation = false;
    });
  }

 Future<void> _loadScreenState() async {
    final lastScreen = await SharedPreferencesUtil.loadScreenState();
    final lastCityName = await SharedPreferencesUtil.loadCity();
    if (lastScreen == 'weather' && lastCityName != null) {
      final lastCity = CityWeatherModel.cities.firstWhere((city) => city.name == lastCityName);
      if (mounted) {
        context.router.replace(CityWeatherRoute(city: lastCity));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildCurrentLocationCard(context, currentLocation, isFetchingLocation, currentLocationWeather),

                ...CityWeatherModel.cities.map((city) => buildCityCard(context, city)),
              ],
            ),
          ),
          Center(
            child: FloatingActionButton(
              onPressed: () async {
                await context.router.push(const InputRoute());
                setState(() {});
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}