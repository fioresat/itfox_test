import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itfox_test/bloc/app_bloc.dart';
import 'package:itfox_test/screens/widgets/weather_case.dart';

class SearchingView extends StatelessWidget {
  final Widget widget;

  SearchingView({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<AppBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          color: Colors.green,
          onPressed: () {
            context.read<AppBloc>().add(
                  const AppEventGoToLogin(),
                );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.place_outlined),
            color: Colors.green,
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppEventLocationWeather(),
                  );
            },
          ),
        ],
      ),
      body: WeatherCase(
        cityController: _cityController,
        onSearch: (city) => weatherBloc.add(
          AppEventGetWeather(city: city),
        ),
        widget: widget,
      ),
    );
  }
}
