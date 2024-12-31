class CityWeatherModel {
  static final List<CityWeatherModel> cities = [];

  final String name;
  final String? country;
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final String? weatherDescription;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final double? lat;
  final double? lon;
  final int? sunRise;
  final int? sunSet;
  final double? rain;
  final int? clouds;
  final int? visibility;

  CityWeatherModel({
    required this.name, 
    this.country,
    this.temp, 
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.weatherDescription,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.lat,
    this.lon,
    this.sunRise,
    this.sunSet,
    this.rain,
    this.clouds,
    this.visibility,
  });

  factory CityWeatherModel.fromJson(Map<String, dynamic> data, double lat, double lon) {
    return CityWeatherModel(
      name: data['name'] ?? '',
      temp: (data['main']['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (data['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (data['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (data['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: (data['main']['pressure'] as num?)?.toInt() ?? 0,
      humidity: (data['main']['humidity'] as num?)?.toInt() ?? 0,
      weatherDescription: data['weather'][0]['description'] ?? '',
      windSpeed: (data['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      windDeg: (data['wind']?['deg'] as num?)?.toInt() ?? 0,
      windGust: (data['wind']?['gust'] as num?)?.toDouble() ?? 0.0,
      lat: lat,
      lon: lon,
      country: data['sys']['country'] ?? '',
      sunRise: data['sys']['sunrise'] ?? 0,
      sunSet: data['sys']['sunset'] ?? 0,
      rain: (data['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
      clouds: (data['clouds']?['all'] as num?)?.toInt() ?? 0,
      visibility: (data['visibility'] as num?)?.toInt() ?? 0,
    );
  }

  static void addCity(CityWeatherModel city) {
    cities.add(city);
  }
}