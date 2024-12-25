import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather/routes/app_router.dart';
import '../../models/city_forecast_model.dart';
import '../../models/city_model.dart';
import '../../services/api_service.dart';
import 'widgets/five_day_forecast.dart';
import 'widgets/weather_parameter.dart';
import 'widgets/forecast_list.dart';

@RoutePage()
class CityWeatherScreen extends StatefulWidget {
  final City city;

  const CityWeatherScreen({super.key, required this.city});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  City? weatherData;
  List<CityForecast>? forecastData;
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
      final weather = await ApiService.fetchWeatherData(
        coordinates.$1,
        coordinates.$2
      );
      final forecast = await ApiService.fetchForecastData(
        coordinates.$1,
        coordinates.$2
      );
      
      setState(() {
        weatherData = weather;
        forecastData = forecast;
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
                          child: forecastData != null
                            ? ForecastList(forecastData: forecastData!)
                            : const Text('No forecast data available'),
                        ),
                        const SizedBox(height: 10),
                        FiveDayForecast(forecastData: forecastData),
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
                                    onTap: () {
                                      print("dslajf");
                                    },
                                  ),
                                  WeatherParameter(
                                    parameterName: "Humidity", 
                                    parameterValue: '${weatherData?.humidity} %',
                                    onTap: () {
                                      print("dlsakjf");
                                    }
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
                                    onTap: () {
                                      print("dslajf");
                                    },
                                  ),
                                  WeatherParameter(
                                    parameterName: "Wind speed", 
                                    parameterValue: '${weatherData?.windSpeed} m/s',
                                    onTap: () {
                                      print("dlsakjf");
                                    }
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
                                    onTap: () {
                                      print('${weatherData?.sunRise}');
                                    },
                                    bottomText: 'Sunset ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(weatherData!.sunSet! * 1000).toLocal())}',
                                  ),
                                  WeatherParameter(
                                    parameterName: "Visibility", 
                                    parameterValue: '${weatherData?.visibility} m',
                                    onTap: () {
                                      print("dlsakjf");
                                    }
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherParameter(
                                    parameterName: "Rain", 
                                    parameterValue: '${weatherData?.rain} mm',
                                    onTap: () {
                                      print("dslajf");
                                    },
                                  ),
                                  WeatherParameter(
                                    parameterName: "Clouds", 
                                    parameterValue: '${weatherData?.clouds} %',
                                    onTap: () {
                                      print("dlsakjf");
                                    }
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
                        context.router.push(const MapRoute());
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