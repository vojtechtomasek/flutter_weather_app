class CityHistoryModel {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;

  CityHistoryModel({
    required this.dt, 
    required this.temp,
    required this.feelsLike, 
    required this.pressure,
    required this.humidity,
  });
}