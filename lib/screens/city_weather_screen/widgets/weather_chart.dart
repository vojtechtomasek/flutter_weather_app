import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_hourly_model.dart';
import 'package:weather/models/city_history_model.dart';
import 'package:fl_chart/fl_chart.dart';

class WeatherChart extends StatelessWidget {
  final List<CityHistoryModel> historyData;
  final List<CityForecastHourlyModel> forecastHourlyData;
  final String parameter;

  const WeatherChart({
    super.key,
    required this.historyData,
    required this.forecastHourlyData,
    required this.parameter,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> combinedData = _getCombinedData();
    final List<dynamic> values = combinedData.map((data) => data['value']).toList();
    double min = calculateMin(values.cast<double>(), 2);
    double max = calculateMax(values.cast<double>(), 2);
    double interval = calculateInterval(min, max, 5);

    min = min.roundToDouble();
    max = max.roundToDouble();
    interval = (interval / 1).roundToDouble();

    final now = DateTime.now().hour;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value % interval == 0) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 12),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                reservedSize: 40,
                interval: interval,
              ),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          minY: min,
          maxY: max,
          lineBarsData: [
            LineChartBarData(
              spots: values
                  .asMap()
                  .entries
                  .map((entry) {
                    final spot = FlSpot(entry.key.toDouble(), entry.value);
                    return spot;
                  })
                  .toList(),
              isCurved: false,
              gradient: LinearGradient(
                colors: const [Colors.blueGrey, Colors.blue],
                stops: [now / (values.length - 1), now / (values.length - 1)],
                ),
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey.withOpacity(0.2),
                    Colors.blue.withOpacity(0.2),
                  ],
                  stops: [now / (values.length-1), now / (values.length-1)],
                )
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipColor: (touchedSpot) => Colors.grey[850] ?? Colors.black,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '',
                    const TextStyle(),
                    children: [
                      TextSpan(
                        text: '${spot.x.toStringAsFixed(2)}\n',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: spot.y.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
            getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: Colors.blue.withOpacity(0.2),
                    strokeWidth: 4,
                    dashArray: [8, 4],
                  ),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 8,
                        color: Colors.blue,
                      );
                    },
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getCombinedData() {
    final List<Map<String, dynamic>> combinedData = [];
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Add historical data
    for (var data in historyData) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);
      if (dateTime.isAfter(startOfDay) && dateTime.isBefore(endOfDay)) {
        combinedData.add({
          'time': dateTime,
          'value': _getParameterValue(data),
        });
      }
    }

    // Add forecast data
    for (var data in forecastHourlyData) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);
      if (dateTime.isAfter(startOfDay) && dateTime.isBefore(endOfDay.add(const Duration(hours: 1)))) {
        combinedData.add({
          'time': dateTime,
          'value': _getParameterValue(data),
        });
      }
    }

    return combinedData;
  }

  double _getParameterValue(dynamic data) {
    switch (parameter) {
      case 'feels like':
        if (data is CityHistoryModel) {
          return data.feelsLike - 273.15;
        }
        return data.feelsLike;
      case 'pressure':
        return data.pressure.toDouble();
      case 'humidity':
        return data.humidity.toDouble();
      case 'clouds':
        return data.clouds.toDouble();
      case 'rain':
        return data.rain.toDouble() ?? 0.0;
      case 'wind speed':
        return data.windSpeed.toDouble();
      default:
        if (data is CityHistoryModel) {
          return data.temp - 273.15;
        }
        return data.temp;
    }
  }

  double calculateMin(List<double> data, double buffer) {
    return data.reduce((a, b) => a < b ? a : b) - buffer;
  }

  double calculateMax(List<double> data, double buffer) {
    return data.reduce((a, b) => a > b ? a : b) + buffer;
  }

  double calculateInterval(double min, double max, int divisions) {
    return ((max - min) / divisions).ceilToDouble();
  }
}
