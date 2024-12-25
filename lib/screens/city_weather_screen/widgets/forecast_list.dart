import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_model.dart';

class ForecastList extends StatelessWidget {
  final List<CityForecast> forecastData;

  const ForecastList({
    super.key,
    required this.forecastData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16.0),
        child: forecastData.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  final forecast = forecastData[index];
                  final time = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == forecastData.length - 1 ? 0 : 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${time.hour}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${forecast.temp.round()}°',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(child: Text('No forecast data available')),
      ),
    );
  }
}