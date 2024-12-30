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
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mapUrlThemplate = isDarkMode 
      ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
      : 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';

    return Scaffold(
      appBar: AppBar(
        title: Text(weatherOperations[_currentLayer] ?? 'Map'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.layers),
              iconSize: 30,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ListView(
                      children: weatherOperations.entries.map((entry) {
                        return ListTile(
                          title: Text(entry.value),
                          onTap: () {
                            setState(() {
                              _currentLayer = entry.key;
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    );
                  },
                );
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
            urlTemplate: mapUrlThemplate,
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
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(widget.lat, widget.lon),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
