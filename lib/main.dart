import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/themes/dark_theme.dart';
import 'package:weather/themes/light_theme.dart';
import 'routes/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env"); 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final brightness = MediaQuery.of(context).platformBrightness;

    final ThemeData theme = brightness == Brightness.dark ? darkTheme : lightTheme;
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      theme: theme,
    );
  }
}
