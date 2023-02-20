import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itfox_test/consts.dart';
import 'package:itfox_test/model/weather_data.dart';
import 'package:itfox_test/service/location_service.dart';
import 'package:itfox_test/service/weather_service.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const InitWeatherState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(const LoadingWeatherState());
      try {
        final city = event.city;
        final dataDecoded = await WeatherService().getWeatherByName(city);
        if (dataDecoded == 1) {
          emit(
            const CantFindState(),
          );
        } else if (dataDecoded == 0) {
          emit(
            const NoInternetState(),
          );
        }
        final weatherData = WeatherData.fromJson(dataDecoded);
        final color = _getBackgroundColor(weatherData.temperature.toInt());
        emit(LoadedWeatherState(
          weatherData: weatherData,
          isEmpty: false,
          color: color,
        ));
      } on SocketException catch (_) {
        emit(
          const NoInternetState(),
        );
      }
    });
    on<LocationWeatherEvent>((event, emit) async {
      emit(const LoadingWeatherState());
      try {
        final position = await LocationService().getCurrentPosition();
        final dataDecoded =
            await WeatherService().getWeatherByCoordinates(position!);
        final weatherData = WeatherData.fromJson(dataDecoded);
        final color = _getBackgroundColor(weatherData.temperature.toInt());
        emit(LoadedWeatherState(
          weatherData: weatherData,
          isEmpty: false,
          color: color,
        ));
      } on Exception catch (_) {
        emit(
          const CantFindState(),
        );
      }
    });
  }

  Color _getBackgroundColor(int temp) {
    if (temp > Consts.hotTemperature) {
      return Colors.orange;
    }
    if (temp > Consts.coldTemperature && temp <= Consts.hotTemperature) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }
}
