import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:itfox_test/consts.dart';
import 'package:itfox_test/model/auth_model.dart';
import 'package:itfox_test/model/weather_data.dart';
import 'package:itfox_test/service/location_service.dart';
import 'package:itfox_test/service/weather_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _weatherBox = Hive.box('weather_box');
  final _secretStorage = const FlutterSecureStorage();

  AppBloc()
      : super(
          const AppStateLoggedOut(),
        ) {
    on<AppEventLogIn>(
      (event, emit) async {
        final user = AuthModel(
          email: event.email,
          password: event.password,
        );

        if (user.compare(Consts.testEmail, Consts.testPassword)) {
          await _secretStorage.write(key: 'key_email', value: user.email);
          await _secretStorage.write(key: 'key_password', value: user.password);
          emit(
            const InitWeatherState(),
          );
        } else {
          emit(
            const AppStateLoggedOut(message: Consts.errorMessage),
          );
        }
      },
    );
    on<AppEventGoToLogin>(
      (event, emit) async {
        await _secretStorage.delete(key: 'key_email');
        await _secretStorage.delete(key: 'key_password');
        emit(
          const AppStateLoggedOut(),
        );
      },
    );
    on<AppEventInitialize>(
      (event, emit) async {
        emit(
          const AppStateSplashScreen(),
        );
        await Future.delayed(
          const Duration(seconds: 1),
        );
        final user = AuthModel(
          email: await _secretStorage.read(key: 'key_email'),
          password: await _secretStorage.read(key: 'key_password'),
        );
        if (user.compare(Consts.testEmail, Consts.testPassword)) {
          emit(
            const InitWeatherState(),
          );
        } else {
          emit(
            const AppStateLoggedOut(),
          );
        }
      },
    );
    on<AppEventGetWeather>((event, emit) async {
      emit(const LoadingWeatherState());
      try {
        final city = event.city;
        final dataDecoded = await WeatherService().getWeatherByName(city);
        if (dataDecoded == 1) {
          emit(
            const ErrorWeatherState(
              errorMessage: Consts.weatherErrorMessage,
            ),
          );
        } else if (dataDecoded == 0) {
          if (_weatherBox.containsKey(city)) {
            final weatherData = _weatherBox.get(city);
            final color = _getBackgroundColor(
              weatherData.temperature.toInt(),
            );
            emit(LoadedWeatherState(
              weatherData: weatherData,
              isConnected: false,
              color: color,
            ));
          } else {
            emit(
              const ErrorWeatherState(
                errorMessage: Consts.internetConnectionErrorMessage,
              ),
            );
          }
        }
        final weatherData = WeatherData.fromJson(dataDecoded);
        if (!_weatherBox.containsKey(city)) {
          await _weatherBox.put(city, weatherData);
        } else {
          _weatherBox.delete(city);
          await _weatherBox.put(city, weatherData);
        }

        final color = _getBackgroundColor(
          weatherData.temperature.toInt(),
        );

        emit(LoadedWeatherState(
          weatherData: weatherData,
          color: color,
        ));
      } on Exception catch (_) {
        emit(
          const ErrorWeatherState(
            errorMessage: Consts.errorMessage,
          ),
        );
      }
    });
    on<AppEventLocationWeather>((event, emit) async {
      emit(const LoadingWeatherState());
      try {
        if (await Geolocator.isLocationServiceEnabled()) {
          final position = await LocationService().getCurrentPosition();
          final dataDecoded =
              await WeatherService().getWeatherByCoordinates(position!);
          final weatherData = WeatherData.fromJson(dataDecoded);
          final color = _getBackgroundColor(weatherData.temperature.toInt());
          emit(LoadedWeatherState(
            weatherData: weatherData,
            color: color,
          ));
        } else {
          emit(const InitWeatherState());
        }
      } on Exception catch (e) {
        print(e);
        emit(
          const ErrorWeatherState(
            errorMessage: Consts.weatherErrorMessage,
          ),
        );
      }
    });
  }

  Color _getBackgroundColor(int temp) {
    if (temp > Consts.hotTemperature) {
      return Colors.orangeAccent;
    }
    if (temp > Consts.coldTemperature && temp <= Consts.hotTemperature) {
      return Colors.limeAccent;
    } else {
      return Colors.lightBlueAccent;
    }
  }
}
