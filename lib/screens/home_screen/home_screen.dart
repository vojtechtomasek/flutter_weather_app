import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/routes/app_router.dart';
import 'widgets/build_city_card.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cityCount = City.cities.length;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cityCount != City.cities.length) {
      setState(() {
        _cityCount = City.cities.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: City.cities.map((city) => buildCityCard(context, city)).toList(),
            ),
          ),
          Center(
            child: FloatingActionButton(
              onPressed: () async {
                await context.router.push(const InputRoute());
                setState(() {});
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.search, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}