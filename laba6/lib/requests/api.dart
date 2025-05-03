import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/nasa_response.dart';

class ApiService {
  static const String _baseUrl = 'https://api.nasa.gov/mars-photos/api/v1';
  static const String _apiKey = 'GhAF8huQ2y2YTJ6qIlPJnkxdFdW1Mrh7XHobmk1h';

static Future<NasaResponse> getPhotos() async {
  final url = Uri.parse(
    '$_baseUrl/rovers/curiosity/photos?sol=100&api_key=$_apiKey', // Заменили на curiosity так как для opportunity не работает
     //и ссылка на картинки при переходе ведет не туда куда надо
     // при переходе через нее перекидывает не на картнику
  );

    final response = await http.get(url,
    headers: {'User-Agent': 'YourApp/1.0',
    'Accept': 'image/jpeg',},
    );

    if (response.statusCode == 200) {
      return NasaResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка: ${response.statusCode}');
    }
  }
}
