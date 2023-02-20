import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:itfox_test/bloc/weather_bloc.dart';
import 'package:itfox_test/screens/widgets/search_form.dart';
import 'package:itfox_test/screens/widgets/weather_card.dart';
import 'package:itfox_test/screens/widgets/weather_case.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is InitWeatherState) {
                return WeatherCase(
                  cityController: _cityController,
                  onSearch: (city) =>
                      weatherBloc.add(GetWeatherEvent(city: city)),
                  widget: const SizedBox(),
                );
              } else if (state is LoadingWeatherState) {
                return WeatherCase(
                  cityController: _cityController,
                  onSearch: (city) =>
                      weatherBloc.add(GetWeatherEvent(city: city)),
                  widget: const CircularProgressIndicator(),
                );
              } else if (state is LoadedWeatherState) {
                return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0, 1.0],
                      colors: [state.color, Colors.white],
                    ),
                  ),
                  child: WeatherCase(
                    cityController: _cityController,
                    onSearch: (city) =>
                        weatherBloc.add(GetWeatherEvent(city: city)),
                    widget: WeatherCard(
                      weatherData: state.weatherData!,
                      city: state.city!,
                    ),
                  ),
                );
              } else if (state is CantFindState) {
                return WeatherCase(
                  cityController: _cityController,
                  onSearch: (city) =>
                      weatherBloc.add(GetWeatherEvent(city: city)),
                  widget: const Text(
                    'Unknown place. Please try again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                );
              } else if (state is NoInternetState) {
                return WeatherCase(
                  cityController: _cityController,
                  onSearch: (city) =>
                      weatherBloc.add(GetWeatherEvent(city: city)),
                  widget: const Text(
                    'Please, check your internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
