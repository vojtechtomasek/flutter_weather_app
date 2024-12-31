class CityHistoryModel {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final int clouds;
  final double? rain;
  final double windSpeed;

  CityHistoryModel({
    required this.dt, 
    required this.temp,
    required this.feelsLike, 
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.rain,
    required this.windSpeed,
  });

  factory CityHistoryModel.fromJson(Map<String, dynamic> historyData) {
    return CityHistoryModel(
      dt: historyData['dt'] ?? 0,
      temp: (historyData['main']['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (historyData['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      pressure: (historyData['main']['pressure'] as num?)?.toInt() ?? 0,
      humidity: (historyData['main']['humidity'] as num?)?.toInt() ?? 0,
      clouds: (historyData['clouds']['all'] as num?)?.toInt() ?? 0,
      rain: (historyData['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (historyData['wind']['speed'] as num?)?.toDouble() ?? 0.0,
    );
  }
}