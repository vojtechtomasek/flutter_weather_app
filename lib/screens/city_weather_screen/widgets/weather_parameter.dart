import 'package:flutter/material.dart';

class WeatherParameter extends StatelessWidget {
  final String parameterName;
  final dynamic parameterValue;
  final VoidCallback? onTap;

  const WeatherParameter({
    super.key,
    required this.parameterName,
    required this.parameterValue,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      child: InkWell(
        onTap: onTap,
        child: Card( 
          child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(parameterName, style: const TextStyle(color: Colors.blueGrey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("$parameterValue", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}