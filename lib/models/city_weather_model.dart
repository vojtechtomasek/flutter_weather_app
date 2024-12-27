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

  static void addCity(CityWeatherModel city) {
    cities.add(city);
  }
}