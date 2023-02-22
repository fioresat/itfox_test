import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:itfox_test/consts.dart';

class FetchHelper {
  final String cityName;

  FetchHelper({
    this.cityName = '',
  });

  Future<dynamic> getData() async {
    final fullUrl =
        '${Consts.baseUrl}${Consts.getWeatherRequest}?$cityName&appid=${Consts.openWeatherMapKey}&units=metric';

    try {
      http.Response response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body;
      } else {
        return 1;
      }
    } on SocketException catch (_) {
      return 0;
    }
  }
}
