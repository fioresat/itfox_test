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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 50),
          padding:
              const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 00),
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.cityController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter City',
                  ),
                  onSubmitted: (String city) => widget.onSearch!(city),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.green,
                onPressed: () {
                  widget.onSearch!(widget.cityController.text);
                },
              )
            ],
          ),
        ),
        widget.widget,
      ],
    );
  }
}
