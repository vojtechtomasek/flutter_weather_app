import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../services/navigation_service.dart';

@RoutePage()
class InputScreen extends StatelessWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  NavigationService.fetchAndNavigate(context, controller.text);
                },
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}