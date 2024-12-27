import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_hourly_model.dart';

class ForecastList extends StatelessWidget {
  final List<CityForecastHourlyModel> forecastHourlyData;

  const ForecastList({
    super.key,
    required this.forecastHourlyData,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final next24Hours = now.add(Duration(hours: 24));
    final filteredForecastData = forecastHourlyData.where((forecast) {
      final forecastTime = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
      return forecastTime.isAfter(now) && forecastTime.isBefore(next24Hours);
    }).toList();

    return Card(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16.0),
        child: filteredForecastData.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredForecastData.length,
                itemBuilder: (context, index) {
                  final forecast = filteredForecastData[index];
                  final time = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == filteredForecastData.length - 1 ? 0 : 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
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