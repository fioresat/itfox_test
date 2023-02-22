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
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 50,
          left: 20,
        ),
        child: Column(
          children: [
            Row(
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
            const SizedBox(
              height: 20,
            ),
            widget.widget,
          ],
        ),
      ),
    );
  }
}
