part of 'weather_bloc.dart';


@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

@immutable
class LocationWeatherEvent implements WeatherEvent {


  const LocationWeatherEvent() : super();
}

@immutable
class GetWeatherEvent implements WeatherEvent {
  final String city;

  const GetWeatherEvent({
    required this.city,
  }) : super();
}
