import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:auto_route/auto_route.dart';

import '../utils/map_constants.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  final double lat;
  final double lon;

  const MapScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _currentLayer = 'PAC0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weatherOperations[_currentLayer] ?? 'Map'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.layers),
              iconSize: 30,
              onSelected: (String value) {
                setState(() {
                  _currentLayer = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return weatherOperations.entries.map((entry) {
                  return PopupMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(widget.lat, widget.lon),
          initialZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
            additionalOptions: const {
              'tileSize': '256',
            },
          ),
          TileLayer(
            urlTemplate: 'http://maps.openweathermap.org/maps/2.0/weather/$_currentLayer/{z}/{x}/{y}?appid=${dotenv.env['OPENWEATHER_API_KEY']}',
            additionalOptions: const {
              'tileSize': '256',
            },
          ),
        ],
      ),
    );
  }
}
