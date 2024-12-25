import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_model.dart';

class FiveDayForecast extends StatelessWidget {
  final List<CityForecast>? forecastData;

  const FiveDayForecast({super.key, this.forecastData});

  @override
  Widget build(BuildContext context) {
    if (forecastData == null || forecastData!.isEmpty) {
      return const Center(child: Text('No forecast data available'));
    }

    final dailyForecasts = _groupForecastByDay(forecastData!);
    final allForecasts = forecastData!;
    final minTemp = allForecasts.map((f) => f.tempMin).reduce((a, b) => a < b ? a : b);
    final maxTemp = allForecasts.map((f) => f.tempMax).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '5 Day Forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 10),
              Column(
                children: List.generate(dailyForecasts.entries.length, (index) {
                  final entry = dailyForecasts.entries.elementAt(index);
                  final date = entry.key;
                  final forecasts = entry.value;
                  final dayMinTemp = forecasts.map((f) => f.tempMin).reduce((a, b) => a < b ? a : b);
                  final dayMaxTemp = forecasts.map((f) => f.tempMax).reduce((a, b) => a > b ? a : b);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDate(date),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    '${dayMinTemp.round()}°',
                                    style: const TextStyle(color: Colors.blueGrey),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 191, 191, 191),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    Positioned(
                                      left: (dayMinTemp - minTemp) / (maxTemp - minTemp) * 100,
                                      right: (maxTemp - dayMaxTemp) / (maxTemp - minTemp) * 100,
                                      child: Container(
                                        height: 10,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Colors.blue, Colors.blueAccent],
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 25,
                                  child: Text(
                                    '${dayMaxTemp.round()}°',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (index != dailyForecasts.entries.length - 1) const Divider(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<DateTime, List<CityForecast>> _groupForecastByDay(List<CityForecast> forecasts) {
    final Map<DateTime, List<CityForecast>> groupedForecasts = {};

    for (var forecast in forecasts) {
      final date = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
      final day = DateTime(date.year, date.month, date.day);

      if (!groupedForecasts.containsKey(day)) {
        groupedForecasts[day] = [];
      }

      groupedForecasts[day]!.add(forecast);
    }

    return groupedForecasts;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (date == today) {
      return 'Today';
    } else {
      return ['Monday', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    }
  }
}