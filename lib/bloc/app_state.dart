part of 'app_bloc.dart';

@immutable
abstract class AppState {
  final String? city;
  final WeatherData? weatherData;
  final bool isConnected;
  final Color color;
  final String? errorMessage;

  const AppState({
    this.errorMessage,
    this.color = Colors.white,
    this.city,
    this.weatherData,
    this.isConnected = true,
  });
}

@immutable
class InitWeatherState extends AppState {
  const InitWeatherState();
}

@immutable
class LoadingWeatherState extends AppState {
  const LoadingWeatherState();
}

@immutable
class AppStateSplashScreen extends AppState {
  const AppStateSplashScreen();
}

@immutable
class LoadedWeatherState extends AppState {
  const LoadedWeatherState({
    super.color,
    required super.weatherData,
    super.isConnected,
  });
}

@immutable
class ErrorWeatherState extends AppState {
  const ErrorWeatherState({super.errorMessage});
}

@immutable
class AppStateLoggedOut extends AppState {
  final String message;

  const AppStateLoggedOut({this.message = ''});
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView();
}
