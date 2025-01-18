import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenges and Games',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ChallengesGamesPage(),
    );
  }
}

class ChallengesGamesPage extends StatelessWidget {
  const ChallengesGamesPage({Key? key}) : super(key: key);

  void _navigateToChallenge(BuildContext context, String challengeName) {
    Widget page;
    switch (challengeName) {
      case '10 Day Challenge':
        page = const TenDayChallenge();
        break;
      case 'Grateful Jar Challenge':
        page = const GratefulJarPage();
        break;
      case 'Positive Affirmation Bingo':
        page = const PositiveAffirmationBingo();
        break;
      case 'Recovery Trivia':
        page = const RecoveryTrivia();
        break;
      default:
        page =
            Scaffold(body: Center(child: Text('$challengeName coming soon!')));
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String imagePath,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToChallenge(context, title),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7CDB8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Join'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Challenges',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildChallengeCard(
                title: '10 Day Challenge',
                imagePath: 'assets/games/10_day_challenge.jpg',
                context: context,
              ),
              _buildChallengeCard(
                title: 'Grateful Jar Challenge',
                imagePath: 'assets/games/grateful_jar.jpg',
                context: context,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Games',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildChallengeCard(
                title: 'Positive Affirmation Bingo',
                imagePath: 'assets/games/bingo.jpg',
                context: context,
              ),
              _buildChallengeCard(
                title: 'Recovery Trivia',
                imagePath: 'assets/games/trivia.jpg',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TenDayChallenge extends StatefulWidget {
  const TenDayChallenge({Key? key}) : super(key: key);

  @override
  State<TenDayChallenge> createState() => _TenDayChallengeState();
}

class _TenDayChallengeState extends State<TenDayChallenge> {
  final List<bool> completedTasks = List.filled(10, false);

  final tasks = [
    'Write down one goal you want to achieve',
    'Meditate for 10 minutes',
    'Write a letter of gratitude to yourself',
    'Go for a walk and observe nature',
    'Compliment a friend or family member',
    'Try a new healthy recipe',
    'Reflect on one thing you learned this week',
    'Write down three affirmations and say them out loud',
    'Take a social media detox for the day',
    'Plan your next 10 days with positivity',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('10 Day Challenge'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    'Day ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                title: Text(
                  tasks[index],
                  style: TextStyle(
                    fontSize: 18,
                    decoration: completedTasks[index]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: completedTasks[index] ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: Checkbox(
                  value: completedTasks[index],
                  onChanged: (bool? value) {
                    setState(() {
                      completedTasks[index] = value!;
                    });
                    if (value! && !completedTasks.contains(false)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Congratulations! 🎉'),
                          content: const Text(
                            'You\'ve completed all 10 days! Keep up the great work!',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Thank you!'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  activeColor: Colors.blue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GratefulJarPage extends StatefulWidget {
  const GratefulJarPage({Key? key}) : super(key: key);

  @override
  _GratefulJarPageState createState() => _GratefulJarPageState();
}

class _GratefulJarPageState extends State<GratefulJarPage> {
  List<String> notes = [];
  int streakCount = 0;
  DateTime? lastGratitudeDate;
  double jarFill = 0.0;
  String positiveMessage = "";

  void _addGratitude(String note) {
    setState(() {
      notes.add(note);
      jarFill = (notes.length * 10).clamp(0, 100).toDouble();
      if (jarFill >= 100) {
        positiveMessage = "🎉 You've filled the jar! Great job! 🌟";
      }
    });
    _updateStreak();
  }

  void _updateStreak() {
    DateTime today = DateTime.now();
    if (lastGratitudeDate == null ||
        today.difference(lastGratitudeDate!).inDays > 1) {
      streakCount = 1;
    } else if (today.difference(lastGratitudeDate!).inDays == 1) {
      streakCount++;
    }
    lastGratitudeDate = today;
  }

  String get streakMessage {
    if (streakCount == 0) return "Start your gratitude journey!";
    return "Streak: $streakCount days 🌟";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grateful Jar'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              streakMessage,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 150,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.lightBlue[100],
                      border:
                          Border.all(color: Colors.lightBlueAccent, width: 2),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 150,
                    height: 250 * (jarFill / 100),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16)),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.local_drink,
                            size: 100, color: Colors.white),
                        Text(
                          "${jarFill.toInt()}%",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
                height: 30), // Added space between the jar and the button
            if (positiveMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  positiveMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add Gratitude'),
                      content: TextField(
                        onSubmitted: (note) {
                          _addGratitude(note);
                          Navigator.pop(context);
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter your gratitude note"),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white, // White text color
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.add),
              label: const Text("Add Gratitude"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlueAccent,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        notes[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PositiveAffirmationBingo extends StatefulWidget {
  const PositiveAffirmationBingo({Key? key}) : super(key: key);

  @override
  State<PositiveAffirmationBingo> createState() =>
      _PositiveAffirmationBingoState();
}

class _PositiveAffirmationBingoState extends State<PositiveAffirmationBingo> {
  final affirmations = [
    'I am strong.',
    'I believe in myself.',
    'I can achieve my goals.',
    'I am resilient.',
    'I am grateful for my journey.',
    'I deserve happiness.',
    'I choose positivity.',
    'I am proud of myself.',
    'I am enough.',
  ];
  final selected = List<bool>.filled(9, false);

  bool _checkBingo() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (selected[i] && selected[i + 1] && selected[i + 2]) return true;
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (selected[i] && selected[i + 3] && selected[i + 6]) return true;
    }
    // Check diagonals
    if ((selected[0] && selected[4] && selected[8]) ||
        (selected[2] && selected[4] && selected[6])) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Positive Affirmation Bingo')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: affirmations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected[index] = !selected[index];
              });
              if (_checkBingo()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bingo! 🎉')),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: selected[index]
                    ? Colors.lightGreen
                    : Colors.lightGreenAccent,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  affirmations[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecoveryTrivia extends StatefulWidget {
  const RecoveryTrivia({Key? key}) : super(key: key);

  @override
  State<RecoveryTrivia> createState() => _RecoveryTriviaState();
}

class _RecoveryTriviaState extends State<RecoveryTrivia> {
  final questions = [
    {
      'question': 'What is the first step in recovery?',
      'options': ['Acknowledgment', 'Denial', 'Isolation', 'Avoidance'],
      'answer': 'Acknowledgment',
    },
    {
      'question': 'How much water should you drink daily?',
      'options': ['2 liters', '5 liters', '1 liter', '10 liters'],
      'answer': '2 liters',
    },
    {
      'question': 'What is a healthy way to manage stress?',
      'options': [
        'Meditation',
        'Overeating',
        'Isolation',
        'Excessive TV watching'
      ],
      'answer': 'Meditation',
    },
    {
      'question': 'What is the importance of sleep for recovery?',
      'options': [
        'To heal the body',
        'To avoid stress',
        'To skip challenges',
        'It has no role'
      ],
      'answer': 'To heal the body',
    },
    {
      'question': 'What is a good way to develop discipline?',
      'options': [
        'Set daily goals',
        'Procrastinate',
        'Avoid challenges',
        'Overcommit'
      ],
      'answer': 'Set daily goals',
    },
  ];

  int score = 0;
  int currentQuestionIndex = 0;
  bool answered = false;

  void _nextQuestion(bool correct) {
    if (!answered) {
      if (correct) score++;
      setState(() {
        answered = true;
      });
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          answered = false;
        } else {
          _showFinalScore();
        }
      });
    });
  }

  void _showFinalScore() {
    String message;
    String emoji;
    switch (score) {
      case 5:
        message = 'Well played! 🎉🙌';
        emoji = '🌟🌟🌟🌟🌟';
        break;
      case 4:
        message = 'Good job! 👍✨';
        emoji = '🌟🌟🌟🌟';
        break;
      case 3:
        message = 'Okay! 😌👌';
        emoji = '🌟🌟🌟';
        break;
      case 2:
        message = 'Nah fam... 😕';
        emoji = '🌟🌟';
        break;
      default:
        message = 'You are cooked! 🫠';
        emoji = '🌟';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text(
          'Score: $score/5\n$message\n$emoji',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery Trivia'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the question number and text
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question['question'] as String,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            // Options with RadioListTile
            ...(question['options'] as List<String>).map(
              (option) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RadioListTile<String>(
                  title: Text(
                    option,
                    style: const TextStyle(fontSize: 16),
                  ),
                  value: option,
                  groupValue: answered ? question['answer'] as String? : null,
                  onChanged: (value) {
                    if (!answered) {
                      final correct = value == question['answer'];
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            correct
                                ? 'Correct! 🎉'
                                : 'Wrong! Correct answer: ${question['answer']} 😔',
                          ),
                          backgroundColor: correct ? Colors.green : Colors.red,
                        ),
                      );
                      _nextQuestion(correct);
                    }
                  },
                  activeColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
