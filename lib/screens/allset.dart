import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/custom_scaffold.dart'; // Assuming this file defines CustomScaffold
import 'package:flutterapp/screens/home.dart'; // Assuming TopicsScreen is in the same directory

class AllSetPage extends StatelessWidget {
  const AllSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centers content vertically
          children: [
            const Text(
              'All Set and Ready!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Matches custom background
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TopicsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TopicsScreen(),
                  ),
                );
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
