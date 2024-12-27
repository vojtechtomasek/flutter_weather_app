import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_daily_model.dart';

class TenDayForecast extends StatelessWidget {
  final List<CityForecastDailyModel>? forecastData;

  const TenDayForecast({super.key, this.forecastData});

  @override
  Widget build(BuildContext context) {
    if (forecastData == null || forecastData!.isEmpty) {
      return const Center(child: Text('No forecast data available'));
    }

    final overallMinTemp = forecastData!.map((f) => f.minTemp).reduce((a, b) => a < b ? a : b);
    final overallMaxTemp = forecastData!.map((f) => f.maxTemp).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 10),
              Column(
                children: List.generate(forecastData!.length, (index) {
                  final forecast = forecastData![index];
                  final date = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);

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
                                    '${forecast.minTemp.round()}°',
                                    style: const TextStyle(color: Colors.blueGrey),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 100,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 191, 191, 191),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: ((forecast.minTemp - overallMinTemp) / (overallMaxTemp - overallMinTemp) * 100).clamp(0, 100),
                                        right: ((overallMaxTemp - forecast.maxTemp) / (overallMaxTemp - overallMinTemp) * 100).clamp(0, 100),
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
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 25,
                                  child: Text(
                                    '${forecast.maxTemp.round()}°',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (index != forecastData!.length - 1) const Divider(),
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