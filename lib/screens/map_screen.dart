import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:auto_route/auto_route.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(widget.lat, widget.lon),
          initialZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(37.7749, -122.4194),
                width: 80.0,
                height: 80.0,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
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