import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather/models/city_forecast_hourly_model.dart';
import 'package:weather/models/city_history_model.dart';

class WeatherChart extends StatelessWidget {
  final List<CityHistoryModel> historyData;
  final List<CityForecastHourlyModel> forecastHourlyData;

  const WeatherChart({
    super.key,
    required this.historyData,
    required this.forecastHourlyData,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 5,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                  color: Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return const FlLine(
                  color: Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 5,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 42,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d)),
            ),
            minX: 0,
            maxX: 23,
            minY: 0,
            maxY: 40,
            lineBarsData: [
              LineChartBarData(
                spots: _getSpots(),
                isCurved: true,
                gradient: const LinearGradient(
                  colors: [Color(0xff23b6e6), Color(0xff02d39a)],
                ),
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff23b6e6).withOpacity(0.3),
                      const Color(0xff02d39a).withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getSpots() {
    final List<FlSpot> spots = [];

    // Add historical data spots
    for (var data in historyData) {
      final hour = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000).hour;
      spots.add(FlSpot(hour.toDouble(), data.temp));
    }

    // Add forecast hourly data spots
    for (var data in forecastHourlyData) {
      final hour = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000).hour;
      spots.add(FlSpot(hour.toDouble(), data.temp));
    }

    return spots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('12 AM', style: style);
        break;
      case 6:
        text = const Text('6 AM', style: style);
        break;
      case 12:
        text = const Text('12 PM', style: style);
        break;
      case 18:
        text = const Text('6 PM', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0°C';
        break;
      case 10:
        text = '10°C';
        break;
      case 20:
        text = '20°C';
        break;
      case 30:
        text = '30°C';
        break;
      case 40:
        text = '40°C';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}