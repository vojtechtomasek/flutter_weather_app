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
      temp: (data['main']['temp'] as num).toDouble(),
      feelsLike: (data['main']['feels_like'] as num).toDouble(),
      tempMin: (data['main']['temp_min'] as num).toDouble(),
      tempMax: (data['main']['temp_max'] as num).toDouble(),
      pressure: (data['main']['pressure'] as num).toInt(),
      humidity: (data['main']['humidity'] as num).toInt(),
      weatherDescription: data['weather'][0]['description'] as String,
      windSpeed: (data['wind']['speed'] as num).toDouble(),
      windDeg: (data['wind']?['deg'] as num?)?.toInt(),
      windGust: (data['wind']?['gust'] as num?)?.toDouble(),
      lat: lat,
      lon: lon,
      country: data['sys']['country'] as String,
      sunRise: data['sys']['sunrise'] as int,
      sunSet: data['sys']['sunset'] as int,
      rain: (data['rain']?['1h'] as num?)?.toDouble() ?? 0.0,
      clouds: (data['clouds']?['all'] as num?)?.toInt(),
      visibility: (data['visibility'] as num?)?.toInt(),  
    );
  }

  static void addCity(CityWeatherModel city) {
    cities.add(city);
  }
}