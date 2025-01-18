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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove 'home' or '/' route conflict
      initialRoute: '/', // Default route is defined here
      routes: {
        '/': (context) => const WelcomeScreen(), // Set WelcomeScreen as the default route
        '/fitness_screen': (context) => WellnessApp(),
<<<<<<< HEAD
        '/recovery_club': (context) => ClubJoinPage(),
      
=======
        '/recover_club' : (context) => ClubJoinPage(),  // This defines the route
>>>>>>> parent of 34d908e (before main edit)
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
    );
  }
}
