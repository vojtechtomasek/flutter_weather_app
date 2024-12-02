import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/routes/app_router.dart';
import '../../models/city_model.dart';

@RoutePage()
class CityWeatherScreen extends StatelessWidget {
  final City city;

  const CityWeatherScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(city.name),
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