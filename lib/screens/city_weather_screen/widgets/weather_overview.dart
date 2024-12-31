import 'package:flutter/material.dart';
import 'package:weather/models/city_weather_model.dart';

class WeatherOverview extends StatelessWidget {
  final CityWeatherModel? weatherData;

  const WeatherOverview({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weatherData!.name, style: const TextStyle(fontSize: 32)),
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
      ],
    );
  }
}