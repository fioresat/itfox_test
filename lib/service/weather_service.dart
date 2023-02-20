import 'package:geolocator/geolocator.dart';
import 'fetch_helper.dart';

class WeatherService {
  Future<dynamic> getWeatherByCoordinates(Position position) async {
    final lat = position.latitude;
    final lon = position.longitude;
    FetchHelper fetchData = FetchHelper(cityName: 'lat=$lat&lon=$lon');
    var decodedData = await fetchData.getData();
    return decodedData;
  }

  Future<dynamic> getWeatherByName(String cityName) async {
    FetchHelper fetchData = FetchHelper(cityName: 'q=$cityName');
    var decodedData = await fetchData.getData();
    return decodedData;
  }
}
