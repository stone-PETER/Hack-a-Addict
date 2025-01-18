import 'package:flutter/material.dart';
import 'package:flutterapp/screens/fitness_screen.dart';
import 'package:flutterapp/screens/club_screen.dart';
import 'package:flutterapp/screens/welcome_screen.dart';
import 'package:flutterapp/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/fitness_screen': (context) => WellnessApp(),
        '/recovery_club' : (context) => ClubJoinPage(),  // This defines the route
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const WelcomeScreen(),
    );
  }
}