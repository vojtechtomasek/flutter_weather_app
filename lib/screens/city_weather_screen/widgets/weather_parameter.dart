import 'package:flutter/material.dart';

class WeatherParameter extends StatelessWidget {
  final String parameterName;
  final int? parameterValue;

  const WeatherParameter({
    super.key,
    required this.parameterName,
    required this.parameterValue
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
        Text(parameterName),
        Text("$parameterValue")
        ],
      ),
    );
  }
}