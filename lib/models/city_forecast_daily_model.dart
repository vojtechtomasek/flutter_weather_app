class CityForecastDailyModel {
  final int dt;
  final int sunrise;
  final int sunset;
  final double dayTemp;
  final double minTemp;
  final double maxTemp;
  final double nightTemp;
  final double eveTemp;
  final double mornTemp;
  final double dayFeelsLike;
  final double nightFeelsLike;
  final double eveFeelsLike;
  final double mornFeelsLike;
  final int pressure;
  final int humidity;
  final String weatherDescription;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int clouds;
  final double pop;
  final double rain;

  CityForecastDailyModel({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.dayTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.nightTemp,
    required this.eveTemp,
    required this.mornTemp,
    required this.dayFeelsLike,
    required this.nightFeelsLike,
    required this.eveFeelsLike,
    required this.mornFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.clouds,
    required this.pop,
    required this.rain,
  });

  factory CityForecastDailyModel.fromJson(Map<String, dynamic> forecastData) {
    return CityForecastDailyModel(
      dt: forecastData['dt'],
      sunrise: forecastData['sunrise'],
      sunset: forecastData['sunset'],
      dayTemp: (forecastData['temp']['day'] as num).toDouble(),
      minTemp: (forecastData['temp']['min'] as num).toDouble(),
      maxTemp: (forecastData['temp']['max'] as num).toDouble(),
      nightTemp: (forecastData['temp']['night'] as num).toDouble(),
      eveTemp: (forecastData['temp']['eve'] as num).toDouble(),
      mornTemp: (forecastData['temp']['morn'] as num).toDouble(),
      dayFeelsLike: (forecastData['feels_like']['day'] as num).toDouble(),
      nightFeelsLike: (forecastData['feels_like']['night'] as num).toDouble(),
      eveFeelsLike: (forecastData['feels_like']['eve'] as num).toDouble(),
      mornFeelsLike: (forecastData['feels_like']['morn'] as num).toDouble(),
      pressure: (forecastData['pressure'] as num).toInt(),
      humidity: (forecastData['humidity'] as num).toInt(),
      weatherDescription: forecastData['weather'][0]['description'],
      windSpeed: (forecastData['speed'] as num).toDouble(),
      windDeg: (forecastData['deg'] as num).toInt(),
      windGust: (forecastData['gust'] as num).toDouble(),
      clouds: (forecastData['clouds'] as num).toInt(),
      pop: (forecastData['pop'] as num).toDouble(),
      rain: (forecastData['rain'] as num?)?.toDouble() ?? 0.0,
    );
  }
}