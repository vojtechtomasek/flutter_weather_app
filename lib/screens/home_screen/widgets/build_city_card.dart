import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/routes/app_router.dart';

Widget buildCityCard(BuildContext context, CityWeatherModel city) {
  return GestureDetector(
    onTap: () {
      context.router.push(CityWeatherRoute(city: city));
    },
    child: Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(city.name),
        leading: const Icon(Icons.location_city),
      ),
    ),
  );
}

Widget buildCurrentLocationCard(BuildContext context, String currentLocation, bool isFetchingLocation, CityWeatherModel? currentLocationWeather) {
  return GestureDetector(
    onTap: () {
      if (currentLocationWeather != null) {
        context.router.push(CityWeatherRoute(city: currentLocationWeather));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get weather data for current location')),
        );
      }
    },
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListTile(
        title: Text(currentLocation),
        subtitle: isFetchingLocation
            ? const Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator()
                ),
            )
            : const Text('Tap to see weather'),
        leading: const Icon(Icons.location_on),
      ),
    ),
  );
}