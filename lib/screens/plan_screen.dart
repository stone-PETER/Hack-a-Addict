import 'package:flutter/material.dart';

// void main() {
//   runApp(const RecoveryPlanApp());
// }

// class RecoveryPlanApp extends StatelessWidget {
//   const RecoveryPlanApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Recovery Plan',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.grey[900],
//       ),
//       home: const PlanScreen(),
//     );
//   }
// }

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int _streakCount = 0;
  bool _isDarkMode = false;
  double _progress = 0.0;

  void _incrementStreak() {
    setState(() {
      _streakCount++;
    });
    _showStreakDialog();
  }

  void _showStreakDialog() {
    if (_streakCount % 5 == 0) { // Show dialog every 5 streaks
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations! 🎉'),
          content: Text('You\'ve achieved a $_streakCount day streak!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Keep Going!'),
            ),
          ],
        ),
      );
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add notification settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Add help section
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsModal,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top section with fire icon and streak count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress indicator
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Progress: ${(_progress * 100).toInt()}%',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: _incrementStreak,
                    child: Row(
                      children: [
                        Image.asset('assets/plan/fire.jpg', height: 30),
                        const SizedBox(width: 4),
                        Text(
                          '$_streakCount',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Title with motivation
              Column(
                children: [
                  const Text(
                    'Welcome To Your\nRecovery Plan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ve got this! 💪',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Grid of options with animations
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildAnimatedGridItem(
                      context,
                      'Targets',
                      'assets/plan/targets.jpg',
                      () => _navigateToSection(context, 'Targets'),
                    ),
                    _buildAnimatedGridItem(
                      context,
                      'Goals',
                      'assets/plan/goals.jpg',
                      () => _navigateToSection(context, 'Goals'),
                    ),
                    _buildAnimatedGridItem(
                      context,
                      'Daily Tasks',
                      'assets/plan/daily_tasks.jpg',
                      () => _navigateToSection(context, 'Daily Tasks'),
                    ),
                    _buildAnimatedGridItem(
                      context,
                      'Education',
                      'assets/plan/education.jpg',
                      () => _navigateToSection(context, 'Education'),
                    ),
                    _buildAnimatedGridItem(
                      context,
                      'Progress',
                      'assets/plan/progress.jpg',
                      () => _navigateToSection(context, 'Progress'),
                    ),
                    _buildAnimatedGridItem(
                      context,
                      'Money Saved',
                      'assets/plan/money_saved.jpg',
                      () => _navigateToSection(context, 'Money Saved'),
                    ),
                  ],
                ),
              ),
              
              // Bottom buttons with improved styling
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BackPage()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MentalRecoveryPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.green[900],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Mental Recovery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add emergency contact feature
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Need Help?'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Emergency Helpline'),
                    subtitle: Text('1-800-XXX-XXXX'),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Crisis Text Line'),
                    subtitle: Text('Text HOME to 741741'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.emergency),
      ),
    );
  }

  Widget _buildAnimatedGridItem(
    BuildContext context,
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 60),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSection(BuildContext context, String section) {
    // Update progress when visiting a new section
    setState(() {
      _progress = (_progress + 0.1).clamp(0.0, 1.0);
    });
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentPage(section: section),
      ),
    );
  }
}

// Rest of the classes (ContentPage, MentalRecoveryPage, BackPage) remain the same
// but you should enhance them with similar styling and features

// Update the ContentPage class with the detailed content implementation

class ContentPage extends StatelessWidget {
  final String section;
  
  const ContentPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final content = _getSectionContent(section);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(section),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: content.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                content[index]['title'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  content[index]['description'] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, String>> _getSectionContent(String section) {
    switch (section) {
      case 'Targets':
        return [
          {
            'title': '30-Day Milestone',
            'description': 'Establish a daily routine incorporating exercise, meditation, and healthy eating habits. Track your progress and celebrate small wins.'
          },
          {
            'title': '60-Day Milestone',
            'description': 'Strengthen social connections by attending support groups and reconnecting with positive influences in your life.'
          },
          {
            'title': '90-Day Milestone',
            'description': 'Develop and maintain new healthy coping mechanisms. Set foundations for long-term lifestyle changes.'
          },
          {
            'title': 'Physical Health',
            'description': 'Aim for 7-8 hours of quality sleep, 30 minutes of daily exercise, and maintaining a balanced diet rich in nutrients.'
          },
          {
            'title': 'Mental Wellness',
            'description': 'Practice daily mindfulness, engage in therapy sessions, and develop emotional awareness through journaling.'
          }
        ];

      case 'Goals':
        return [
          {
            'title': 'Personal Growth',
            'description': 'Identify and work on three key areas of personal development: emotional intelligence, stress management, and boundary setting.'
          },
          {
            'title': 'Career Planning',
            'description': 'Update your resume, explore career counseling options, and identify potential training or education opportunities.'
          },
          {
            'title': 'Relationship Building',
            'description': 'Work on rebuilding trust, improving communication skills, and establishing healthy boundaries in relationships.'
          },
          {
            'title': 'Financial Stability',
            'description': 'Create a monthly budget, set up an emergency fund, and develop a debt management plan if needed.'
          },
          {
            'title': 'Hobby Development',
            'description': 'Explore and engage in two new hobbies that bring joy and dont trigger old patterns.'
          }
        ];

      case 'Daily Tasks':
        return [
          {
            'title': 'Morning Routine',
            'description': 'Wake up at a consistent time, practice 10 minutes of meditation, enjoy a healthy breakfast, and set intentions for the day.'
          },
          {
            'title': 'Self-Care Activities',
            'description': 'Take regular breaks, stay hydrated, practice deep breathing exercises, and maintain personal hygiene.'
          },
          {
            'title': 'Recovery Tasks',
            'description': 'Attend support meetings, complete daily journal entries, practice gratitude, and review coping strategies.'
          },
          {
            'title': 'Evening Routine',
            'description': 'Review daily achievements, prepare for tomorrow, practice relaxation techniques, and maintain a consistent bedtime.'
          },
          {
            'title': 'Social Connection',
            'description': 'Reach out to one supportive person daily, share your progress, and practice active listening in conversations.'
          }
        ];

      case 'Education':
        return [
          {
            'title': 'Understanding Triggers',
            'description': 'Learn to identify personal triggers, understand their root causes, and develop healthy responses to challenging situations.'
          },
          {
            'title': 'Coping Strategies',
            'description': 'Discover and practice various coping techniques: grounding exercises, stress management, and emotional regulation.'
          },
          {
            'title': 'Stress Management',
            'description': 'Learn about different stress reduction techniques, including progressive muscle relaxation, guided imagery, and breathing exercises.'
          },
          {
            'title': 'Healthy Relationships',
            'description': 'Understand the characteristics of healthy relationships, learn effective communication, and practice setting boundaries.'
          },
          {
            'title': 'Recovery Science',
            'description': 'Learn about the science of recovery, brain chemistry, and how lifestyle changes support long-term wellness.'
          }
        ];

      case 'Progress':
        return [
          {
            'title': 'Weekly Reflection',
            'description': 'Review your achievements, challenges faced, and lessons learned. Track your emotional and physical well-being.'
          },
          {
            'title': 'Achievement Log',
            'description': 'Document and celebrate your successes, no matter how small. Include both recovery-related and personal achievements.'
          },
          {
            'title': 'Challenge Management',
            'description': 'Record how you handled difficult situations, what worked, what didnt, and plans for future improvement.'
          },
          {
            'title': 'Recovery Timeline',
            'description': 'Track significant milestones in your recovery journey, including positive changes and overcome obstacles.'
          },
          {
            'title': 'Support Network',
            'description': 'Monitor the growth and effectiveness of your support network, including professional help and peer support.'
          }
        ];

      case 'Money Saved':
        return [
          {
            'title': 'Weekly Savings',
            'description': 'Calculate and track money saved from changed habits. Set this aside for future goals or emergency fund.'
          },
          {
            'title': 'Financial Goals',
            'description': 'Set short-term and long-term financial goals. Track progress towards emergency fund and debt reduction targets.'
          },
          {
            'title': 'Budget Planning',
            'description': 'Create and maintain a realistic budget that supports your recovery while building financial stability.'
          },
          {
            'title': 'Cost Comparison',
            'description': 'Compare previous spending patterns with current healthy choices to visualize financial benefits of recovery.'
          },
          {
            'title': 'Investment Planning',
            'description': 'Learn about and plan for future investments using your saved money. Consider retirement and long-term financial health.'
          }
        ];

      default:
        return [];
    }
  }
}

class MentalRecoveryPage extends StatelessWidget {
  const MentalRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image at the top
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/plan/mental_recovery_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'MENTAL\nRECOVERY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            
            // Mental Wellness Text
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'MENTAL WELLNESS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Every day is a step to a new beginning. Break free from your addictions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 63, 63, 63),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Buttons
                  _buildButton(
                    context,
                    'Daily Talks',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyTalksPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildButton(
                    context,
                    'Motivation',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MotivationPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildButton(
                    context,
                    'Daily Blogs',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyBlogsPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildButton(
                    context,
                    'Emergency Help',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmergencyHelpPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Back Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB2DFDB), // Light mint color
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0, // Adjusted font size
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Content Pages
class DailyTalksPage extends StatelessWidget {
  const DailyTalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Talks'),
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TalkCard(
            title: 'Morning Reflection',
            content: 'Start your day with a 5-minute mindfulness exercise. Focus on your breath and set positive intentions for the day.',
            time: '9:00 AM',
          ),
          TalkCard(
            title: 'Afternoon Check-in',
            content: 'Take a moment to assess your emotional state. What\'s working well today? What challenges have you faced?',
            time: '2:00 PM',
          ),
          TalkCard(
            title: 'Evening Gratitude',
            content: 'List three things you\'re grateful for today. Celebrate your progress, no matter how small.',
            time: '7:00 PM',
          ),
        ],
      ),
    );
  }
}

class MotivationPage extends StatelessWidget {
  const MotivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motivation'),
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          QuoteCard(
            quote: 'Recovery is not a race. You don\'t have to feel guilty if it takes you longer than you thought it would.',
            author: 'Unknown',
          ),
          QuoteCard(
            quote: 'The only person you are destined to become is the person you decide to be.',
            author: 'Ralph Waldo Emerson',
          ),
          QuoteCard(
            quote: 'You are stronger than you know. This moment is temporary.',
            author: 'Recovery Community',
          ),
        ],
      ),
    );
  }
}

class DailyBlogsPage extends StatelessWidget {
  const DailyBlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Blogs'),
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          BlogCard(
            title: 'Finding Peace in Small Moments',
            preview: 'Discover how mindful moments throughout your day can strengthen your recovery journey...',
            date: 'Today',
          ),
          BlogCard(
            title: 'Building Healthy Relationships',
            preview: 'Learn how to establish and maintain supportive connections during recovery...',
            date: 'Yesterday',
          ),
          BlogCard(
            title: 'Stress Management Techniques',
            preview: 'Explore effective ways to handle stress without compromising your recovery...',
            date: '2 days ago',
          ),
        ],
      ),
    );
  }
}

class EmergencyHelpPage extends StatelessWidget {
  const EmergencyHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          EmergencyCard(
            title: 'Crisis Helpline',
            content: '1-800-662-HELP (4357)',
            onTap: () {/* Add phone call functionality */},
          ),
          EmergencyCard(
            title: 'Text Support',
            content: 'Text HOME to 741741',
            onTap: () {/* Add messaging functionality */},
          ),
          EmergencyCard(
            title: 'Local Support Group',
            content: 'Find nearest support group',
            onTap: () {/* Add location functionality */},
          ),
        ],
      ),
    );
  }
}

// Helper Widgets
class TalkCard extends StatelessWidget {
  final String title;
  final String content;
  final String time;

  const TalkCard({
    super.key,
    required this.title,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"$quote"',
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '- $author',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String title;
  final String preview;
  final String date;

  const BlogCard({
    super.key,
    required this.title,
    required this.preview,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(preview),
            const SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTap;

  const EmergencyCard({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackPage extends StatelessWidget {
  const BackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: const Color(0xFFB2DFDB),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Previous Activities',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard(
                    'Daily Progress',
                    'Track your daily achievements and milestones',
                    Icons.track_changes,
                  ),
                  _buildActivityCard(
                    'Journal Entries',
                    'Review your previous journal entries',
                    Icons.book,
                  ),
                  _buildActivityCard(
                    'Support Network',
                    'Connect with your support network',
                    Icons.people,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32, color: const Color(0xFFB2DFDB)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}