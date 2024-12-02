
import '../models/city_model.dart';

class CityRepository {
  static List<City> cities = [];

  static void addCity(City city) {
    cities.add(city);
  }

  // get all cities
  static List<City> getCities() {
    return cities;
  }
}