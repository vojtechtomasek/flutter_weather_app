class City {
  static final List<City> cities = [];

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
  final double? lat;
  final double? lon;

  City({
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
    this.lat,
    this.lon,
  });

  static void addCity(City city) {
    cities.add(city);
  }
}