import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/routes/app_router.dart';
import '../repositories/city_repository.dart';
import '../models/city_model.dart';

@RoutePage()
class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final cityName = _controller.text;
                  final city = City(name: cityName);
                  // Add the city to the repository
                  CityRepository.addCity(city);
                  context.router.push(CityWeatherRoute(city: city));
                },
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}