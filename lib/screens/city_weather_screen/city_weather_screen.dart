import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_forecast_daily_model.dart';
import 'package:weather/models/city_history_model.dart';
import 'package:weather/routes/app_router.dart';
import '../../models/city_forecast_hourly_model.dart';
import '../../models/city_weather_model.dart';
import '../../services/api_service.dart';
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
    
    final coordinates = await ApiService.getCityWithCoordinates(widget.city.name);
    if (coordinates != null) {
      final weatherFuture = ApiService.fetchWeatherData(coordinates.$1, coordinates.$2);
      final forecastHourlyFuture = ApiService.fetchForecastHourlyData(coordinates.$1, coordinates.$2);
      final forecastDailyFuture = ApiService.fetchForecastDailyData(coordinates.$1, coordinates.$2);
      final historyFuture = ApiService.fetchHistoryData(coordinates.$1, coordinates.$2);

      final results = await Future.wait([
        weatherFuture,
        forecastHourlyFuture,
        forecastDailyFuture,
        historyFuture,
      ]);

      setState(() {
        weatherData = results[0] as CityWeatherModel?;
        forecastHourlyData = results[1] as List<CityForecastHourlyModel>?;
        forecastDailyData = results[2] as List<CityForecastDailyModel>?;
        historyData = results[3] as List<CityHistoryModel>?;
        isLoading = false;
      });
    }
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
                        Text(weatherData?.name ?? 'N/A', style: const TextStyle(fontSize: 32)),
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
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(Icons.map, color: Colors.black),
                      onPressed: () {
                        context.router.push(MapRoute(lat: weatherData?.lat ?? 0.0, lon: weatherData?.lon ?? 0.0));
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
      ),
    );
  }
}