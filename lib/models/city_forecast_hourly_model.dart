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
  final double rain;

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
    required this.rain,
  });

  factory CityForecastHourlyModel.fromJson(Map<String, dynamic> forecastData) {
    return CityForecastHourlyModel(
      dt: forecastData['dt'],
      dtTxt: forecastData['dt_txt'] ?? '',
      temp: (forecastData['main']['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (forecastData['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (forecastData['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (forecastData['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: (forecastData['main']['pressure'] as num?)?.toInt() ?? 0,
      humidity: (forecastData['main']['humidity'] as num?)?.toInt() ?? 0,
      weatherDescription: forecastData['weather'][0]['description'] ?? '',
      windSpeed: (forecastData['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      visibility: (forecastData['visibility'] as num?)?.toInt() ?? 0,
      clouds: (forecastData['clouds']['all'] as num?)?.toInt() ?? 0,
      rain: (forecastData['rain']?['3h'] as num?)?.toDouble() ?? 0.0,
    );
  }
}