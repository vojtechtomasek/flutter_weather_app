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
}