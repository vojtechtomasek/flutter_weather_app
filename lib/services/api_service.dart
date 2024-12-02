import 'package:http/http.dart' as http;

class ApiService {
  static String get apiUrl {
    return '';
  }

  static Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}