import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'providers/restaurant_provider.dart';
import 'providers/location_provider.dart';
import 'providers/preferences_provider.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PreferencesProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => RestaurantProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}