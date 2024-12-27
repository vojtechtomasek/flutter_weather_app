class CityForecastHourlyModel {
  final int dt;
  final String dtTxt;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String weatherDescription;
  final double windSpeed;
  final int visibility;
  final int clouds;

  CityForecastHourlyModel({
    required this.dt,
    required this.dtTxt,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.visibility,
    required this.clouds,
  });
}