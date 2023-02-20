part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  final String? city;
  final WeatherData? weatherData;
  final bool isEmpty;
  final Color color;

  const WeatherState({
    this.color = Colors.white,
    this.city,
    this.weatherData,
    this.isEmpty = true,
  });
}

@immutable
class InitWeatherState extends WeatherState {
  const InitWeatherState({
    super.weatherData,
    super.city,
    super.isEmpty,
  });
}

@immutable
class LoadingWeatherState extends WeatherState {
  const LoadingWeatherState({
    super.weatherData,
    super.city,
    super.isEmpty,
  });
}

@immutable
class LoadedWeatherState extends WeatherState {
  const LoadedWeatherState({
    super.color,
    required super.weatherData,
    required super.city,
    required super.isEmpty,
  });
}

@immutable
class CantFindState extends WeatherState {
  const CantFindState({
    super.color,
    super.weatherData,
    super.city,
    super.isEmpty,
  });
}

@immutable
class NoInternetState extends WeatherState {
  const NoInternetState({
    super.color,
    super.weatherData,
    super.city,
    super.isEmpty,
  });
}
