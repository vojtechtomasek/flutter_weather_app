class CityHistoryModel {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final int clouds;
  final double? rain;

  CityHistoryModel({
    required this.dt, 
    required this.temp,
    required this.feelsLike, 
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.rain,
  });
}