import 'package:hive/hive.dart';

part 'weather_data.g.dart';

@HiveType(typeId: 0)
class WeatherData {
  @HiveField(0)
  final double temperature;
  @HiveField(1)
  final String icon;
  @HiveField(2)
  final String feelsLike;
  @HiveField(3)
  final String city;


  WeatherData({
    this.city = '',
    this.icon = '',
    this.feelsLike = '',
    this.temperature = 0,
  });

  WeatherData.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'],
        feelsLike = json['main']['feels_like'].toString(),
        city = json['name'],
        icon = json['weather'][0]['icon'];

  @override
  String toString() {
    return city;
  }
}
