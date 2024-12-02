import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/routes/app_router.dart';
import '../../repositories/city_repository.dart';
import 'widgets/build_city_card.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              children: CityRepository.getCities().map((city) => buildCityCard(context, city)).toList(),
            ),
          ),
          Center(
            child: FloatingActionButton(
              onPressed: () async {
                await context.router.push(const InputRoute());
                setState(() {
                  // Refresh the list 
                });
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