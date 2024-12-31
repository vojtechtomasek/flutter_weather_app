import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_daily_model.dart';
import 'package:weather/models/city_history_model.dart';
import 'package:weather/routes/app_router.dart';
import 'package:weather/screens/city_weather_screen/widgets/weather_overview.dart';
import 'package:weather/utils/weather_data_loader.dart';
import '../../models/city_forecast_hourly_model.dart';
import '../../models/city_weather_model.dart';
import '../../utils/wind_direction.dart';
import 'widgets/ten_day_forecast.dart';
import 'widgets/weather_parameter.dart';
import 'widgets/forecast_list.dart';

@RoutePage()
class CityWeatherScreen extends StatefulWidget {
  final CityWeatherModel city;

  const CityWeatherScreen({super.key, required this.city});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  CityWeatherModel? weatherData;
  List<CityForecastHourlyModel>? forecastHourlyData;
  List<CityForecastDailyModel>? forecastDailyData;
  List<CityHistoryModel>? historyData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCityData();
  }

  Future<void> _loadCityData() async {
    setState(() {
      isLoading = true;
    });

    final data = await loadWeatherData(widget.city.name);

    setState(() {
      weatherData = data['weatherData'] as CityWeatherModel?;
      forecastHourlyData = data['forecastHourlyData'] as List<CityForecastHourlyModel>?;
      forecastDailyData = data['forecastDailyData'] as List<CityForecastDailyModel>?;
      historyData = data['historyData'] as List<CityHistoryModel>?;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        WeatherOverview(weatherData: weatherData, cityName: widget.city.name),
                        const SizedBox(height: 40),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: forecastHourlyData != null
                            ? ForecastList(forecastHourlyData: forecastHourlyData!)
                            : const Text('No forecast data available'),
                        ),
                        const SizedBox(height: 10),

                        TenDayForecast(forecastData: forecastDailyData),
                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherParameter(
                                    parameterName: "Feels like", 
                                    parameterValue: '${weatherData?.feelsLike?.round()}°',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                  ),
                                  WeatherParameter(
                                    parameterName: "Humidity", 
                                    parameterValue: '${weatherData?.humidity} %',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherParameter(
                                    parameterName: "Pressure", 
                                    parameterValue: '${weatherData?.pressure} hPa',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                  ),
                                  WeatherParameter(
                                    parameterName: "Wind speed", 
                                    parameterValue: '${weatherData?.windSpeed} m/s',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                    bottomText: 'Wind direction: ${getWindDirection(weatherData?.windDeg ?? 0)}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherParameter(
                                    parameterName: "Sunrise", 
                                    parameterValue: DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(weatherData!.sunRise! * 1000).toLocal()),
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                    bottomText: 'Sunset ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(weatherData!.sunSet! * 1000).toLocal())}',
                                    showGraph: false,
                                  ),
                                  WeatherParameter(
                                    parameterName: "Visibility", 
                                    parameterValue: '${weatherData?.visibility} m',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                    showGraph: false,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherParameter(
                                    parameterName: "Rain", 
                                    parameterValue: '${weatherData?.rain ?? 0} mm',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                  ),
                                  WeatherParameter(
                                    parameterName: "Clouds", 
                                    parameterValue: '${weatherData?.clouds} %',
                                    historyData: historyData ?? [],
                                    forecastHourlyData: forecastHourlyData ?? [],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: 'map',
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(Icons.map),
                      onPressed: () {
                        context.router.push(MapRoute(lat: weatherData?.lat ?? 0.0, lon: weatherData?.lon ?? 0.0));
                      },
                    ),
                    FloatingActionButton(
                      heroTag: 'home',
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(Icons.menu),
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
      ),
    );
  }
}