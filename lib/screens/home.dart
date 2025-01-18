import 'package:flutter/material.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  int completedTopics = 47;

  void _incrementCompletedTopics() {
    setState(() {
      completedTopics++;
    });
  }

  void _navigateToPage(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Topics',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$completedTopics', // Access state here
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.green.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'ALL CLEAN',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildTopicButton(
                    context,
                    'Your recovery plan',
                    'assets/images/img1.jpg',
                        () => _navigateToPage(context, '/plan'),
                  ),
                  _buildTopicButton(
                    context,
                    'Get to know recovery club',
                    'assets/images/img2.jpg',
                        () => _navigateToPage(context, '/recovery_club'),
                  ),
                  _buildTopicButton(
                    context,
                    'Meet our therapists',
                    'assets/images/img3.jpg',
                        () => _navigateToPage(context, '/therapists'),
                  ),
                  _buildTopicButton(
                    context,
                    'Games and challenges',
                    'assets/images/img4.jpg',
                        () => _navigateToPage(context, '/games'),
                  ),
                  _buildTopicButton(
                    context,
                    'Health and fitness',
                    'assets/images/img5.jpg',
                        () => _navigateToPage(context, '/fitness_screen'),
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: _incrementCompletedTopics, // Update state on button press
            //   child: const Text('Complete a Topic'),
            // ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicButton(
      BuildContext context,
      String title,
      String imagePath,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
