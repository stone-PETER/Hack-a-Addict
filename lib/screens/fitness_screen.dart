import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define models first
class MoodEntry {
  final String mood;
  final String note;
  final DateTime timestamp;

  MoodEntry({
    required this.mood,
    required this.note,
    required this.timestamp,
  });
}

class WorkoutEntry {
  final String type;
  final int duration;
  final String intensity;
  final DateTime timestamp;

  WorkoutEntry({
    required this.type,
    required this.duration,
    required this.intensity,
    required this.timestamp,
  });
}

// void main() {
//   runApp(const WellnessApp());
// }

class WellnessApp extends StatelessWidget {
  const WellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness Tracker',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<MoodEntry> _moodEntries = [];
  final List<WorkoutEntry> _workoutEntries = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addMoodEntry(String mood, String note) {
    setState(() {
      _moodEntries.add(MoodEntry(
        mood: mood,
        note: note,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _addWorkoutEntry(String type, int duration, String intensity) {
    setState(() {
      _workoutEntries.add(WorkoutEntry(
        type: type,
        duration: duration,
        intensity: intensity,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Dashboard(moodEntries: _moodEntries, workoutEntries: _workoutEntries),
      MoodTracker(onAddMoodEntry: _addMoodEntry, entries: _moodEntries),
      WorkoutTracker(onAddWorkoutEntry: _addWorkoutEntry, entries: _workoutEntries),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tracker'),
        elevation: 0,
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final List<WorkoutEntry> workoutEntries;

  const Dashboard({
    super.key,
    required this.moodEntries,
    required this.workoutEntries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSummaryCard(
          'Mood Overview',
          moodEntries.isEmpty ? 'No mood entries yet' : 'Last mood: ${moodEntries.last.mood}',
          Icons.mood,
          Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildSummaryCard(
          'Workout Overview',
          workoutEntries.isEmpty
              ? 'No workout entries yet'
              : 'Last workout: ${workoutEntries.last.type}',
          Icons.fitness_center,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}

class MoodTracker extends StatefulWidget {
  final Function(String, String) onAddMoodEntry;
  final List<MoodEntry> entries;

  const MoodTracker({
    super.key,
    required this.onAddMoodEntry,
    required this.entries,
  });

  @override
  _MoodTrackerState createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  final _noteController = TextEditingController();
  String _selectedMood = 'Happy';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedMood,
                    decoration: const InputDecoration(labelText: 'How are you feeling?'),
                    items: ['Happy', 'Neutral', 'Sad', 'Anxious', 'Energetic']
                        .map((mood) => DropdownMenuItem(
                              value: mood,
                              child: Text(mood),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMood = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Add a note',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      widget.onAddMoodEntry(_selectedMood, _noteController.text);
                      _noteController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Mood entry added')),
                      );
                    },
                    child: const Text('Save Mood'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.entries.length,
              itemBuilder: (context, index) {
                final entry = widget.entries[widget.entries.length - 1 - index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.mood),
                    title: Text(entry.mood),
                    subtitle: Text(
                      '${entry.note}\n${DateFormat('MMM d, y H:mm').format(entry.timestamp)}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutTracker extends StatefulWidget {
  final Function(String, int, String) onAddWorkoutEntry;
  final List<WorkoutEntry> entries;

  const WorkoutTracker({
    super.key,
    required this.onAddWorkoutEntry,
    required this.entries,
  });

  @override
  _WorkoutTrackerState createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  String _selectedType = 'Running';
  String _selectedIntensity = 'Medium';
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(labelText: 'Workout Type'),
                    items: ['Running', 'Walking', 'Cycling', 'Swimming', 'Yoga', 'Strength']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duration (minutes)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedIntensity,
                    decoration: const InputDecoration(labelText: 'Intensity'),
                    items: ['Low', 'Medium', 'High']
                        .map((intensity) => DropdownMenuItem(
                              value: intensity,
                              child: Text(intensity),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedIntensity = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final duration = int.tryParse(_durationController.text) ?? 0;
                      if (duration > 0) {
                        widget.onAddWorkoutEntry(
                          _selectedType,
                          duration,
                          _selectedIntensity,
                        );
                        _durationController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Workout entry added')),
                        );
                      }
                    },
                    child: const Text('Save Workout'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.entries.length,
              itemBuilder: (context, index) {
                final entry = widget.entries[widget.entries.length - 1 - index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(entry.type),
                    subtitle: Text(
                      '${entry.duration} minutes - ${entry.intensity} intensity\n'
                      '${DateFormat('MMM d, y H:mm').format(entry.timestamp)}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}