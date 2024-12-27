import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_weather_model.dart';
import 'package:weather/routes/app_router.dart';

Widget buildCityCard(BuildContext context, CityWeatherModel city) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(city.name),
        onTap: () {
            context.router.push(CityWeatherRoute(city: city));
        },
      ),
    );
}
