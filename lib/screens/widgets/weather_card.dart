import 'package:flutter/material.dart';
import 'package:itfox_test/consts.dart';
import 'package:itfox_test/model/weather_data.dart';

import 'animated_size_widget.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;
  final bool isConnected;

  const WeatherCard({
    Key? key,
    required this.weatherData,
    required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherData.city,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          AnimatedSizeWidget(
            duration: Consts.duration,
            child: isConnected
                ? AnimatedSwitcher(
                    duration: Consts.duration,
                    child: Image.network(
                      "http://openweathermap.org/img/wn/${weatherData.icon}@4x.png",
                      height: 120,
                    ),
                  )
                : const SizedBox(
                    height: 120,
                  ),
          ),
          Text(
            '${weatherData.temperature.toInt()}°',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Feels like ${weatherData.feelsLike}°',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
