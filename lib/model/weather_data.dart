class WeatherData {
  final double temperature;
  final String icon;
  final String feelsLike;
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
}
