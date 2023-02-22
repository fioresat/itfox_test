import 'package:flutter/material.dart';

class WeatherCase extends StatefulWidget {
  final Widget widget;
  final Function(String)? onSearch;

  final TextEditingController cityController;

  const WeatherCase({
    Key? key,
    required this.widget,
    this.onSearch,
    required this.cityController,
  }) : super(key: key);

  @override
  createState() => _WeatherCaseState();
}

class _WeatherCaseState extends State<WeatherCase> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 50,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.cityController,
                    decoration: const InputDecoration(
                      hintText: 'Enter City',
                    ),
                    onSubmitted: (String city) => widget.onSearch!(city),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.green[900],
                  onPressed: () {
                    widget.onSearch!(widget.cityController.text);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.widget,
          ),
        ],
      ),
    );
  }
}
