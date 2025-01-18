import 'package:flutter/material.dart';
import 'package:flutterapp/screens/fitness_screen.dart';
import 'package:flutterapp/screens/home.dart';
import 'package:flutterapp/screens/therapist_screen.dart';
import 'package:flutterapp/screens/club_screen.dart';
import 'package:flutterapp/screens/welcome_screen.dart';
import 'package:flutterapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => JoinedClubsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove 'home' or '/' route conflict
      initialRoute: '/', // Default route is defined here
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => const TopicsScreen(), // Set WelcomeScreen as the default route
        '/fitness_screen': (context) => WellnessApp(),
        '/recovery_club': (context) => const ClubJoinPage(),
        '/joined_clubs': (context) => const JoinedClubsPage(),
        '/therapists': (context) => const TherapistScreen(),
      
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
    );
  }
}
