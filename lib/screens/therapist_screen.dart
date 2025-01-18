import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:math' show pi, sin; // For the wave animation
import 'package:simple_animations/simple_animations.dart'; // For PlayAnimation

List<Map<String, dynamic>> scheduledMeetings = [];

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Therapist App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const TherapistScreen(),
//         debugShowCheckedModeBanner: false);
//   }
// }

class TherapistScreen extends StatelessWidget {
  const TherapistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WaveBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/therapists/therapistBg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'OUR THERAPISTS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                EnhancedTherapistCard(
                  name: 'Dr Varghese Paul',
                  imageUrl: 'assets/therapists/paul_varghese.jpg',
                  specialties: ['Anxiety', 'Depression', 'Trauma'],
                  offersOnline: true,
                  onScheduleTap: () =>
                      _showScheduleDialog(context, 'Dr Varghese Paul'),
                ),
                EnhancedTherapistCard(
                  name: 'Dr Amala Wilson',
                  imageUrl: 'assets/therapists/amala_wilson.jpg',
                  specialties: ['Relationships', 'Stress', 'Depression'],
                  offersOnline: true,
                  onScheduleTap: () =>
                      _showScheduleDialog(context, 'Dr Amala Wilson'),
                ),
                EnhancedTherapistCard(
                  name: 'Dr Wong Ping',
                  imageUrl: 'assets/therapists/wong_kong.jpg',
                  specialties: ['Anxiety', 'PTSD', 'Addiction'],
                  offersOnline: false,
                  onScheduleTap: () =>
                      _showScheduleDialog(context, 'Dr Wong Ping'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpLinePage()),
                        ),
                        child: const Text('Help Line'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ScheduledMeetingsPage()),
                        ),
                        child: const Text('Scheduled Meets'),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showScheduleDialog(BuildContext context, String therapistName) {
    showDialog(
      context: context,
      builder: (context) => ScheduleDialog(therapistName: therapistName),
    );
  }
}

// Wave Background Implementation
class WaveBackground extends StatelessWidget {
  const WaveBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade100,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: WaveWidget(),
          ),
        ],
      ),
    );
  }
}

class WaveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 5),
      builder: (context, value, child) {
        return ClipPath(
          clipper: WaveClipper(value),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade200.withOpacity(0.4),
                  Colors.blue.shade100.withOpacity(0.2),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double position;

  WaveClipper(this.position);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      double y = size.height - 20 * sin((x / size.width * 2 * pi) + position);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Enhanced Therapist Card
class EnhancedTherapistCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> specialties;
  final bool offersOnline;
  final VoidCallback onScheduleTap;

  const EnhancedTherapistCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.specialties,
    required this.offersOnline,
    required this.onScheduleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imageUrl),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (offersOnline)
                        Row(
                          children: const [
                            Icon(Icons.videocam, size: 16, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              'Online Sessions Available',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: specialties.map((specialty) {
                return SpecialtyChip(specialty);
              }).toList(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onScheduleTap,
                child: const Text('Schedule Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialtyChip extends StatelessWidget {
  final String specialty;

  const SpecialtyChip(this.specialty, {Key? key}) : super(key: key);

  IconData getSpecialtyIcon() {
    switch (specialty.toLowerCase()) {
      case 'anxiety':
        return Icons.psychology;
      case 'depression':
        return Icons.mood;
      case 'relationships':
        return Icons.people;
      case 'trauma':
        return Icons.healing;
      case 'stress':
        return Icons.weekend;
      case 'ptsd':
        return Icons.personal_injury;
      case 'addiction':
        return Icons.medical_services;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(getSpecialtyIcon(), size: 16, color: Colors.blue.shade700),
          const SizedBox(width: 4),
          Text(
            specialty,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class SlideInAnimation extends StatelessWidget {
  final Widget child;

  const SlideInAnimation({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(-1, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 700), // Slightly slower
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: value * MediaQuery.of(context).size.width,
          child: child,
        );
      },
    );
  }
}

// Schedule Dialog (unchanged)

class ScheduleDialog extends StatefulWidget {
  final String therapistName;

  // Renamed constructor and made 'key' a super parameter
  const ScheduleDialog({Key? key, required this.therapistName})
      : super(key: key);

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  // Make _calendarFormat final
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select a Date for Appointment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(
                  2020, 1, 1), // Set a start date (first selectable day)
              lastDay: DateTime.utc(
                  2025, 12, 31), // Set an end date (last selectable day)
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedDay != null) {
                  setState(() {
                    scheduledMeetings.add({
                      'date': _selectedDay!.toLocal(),
                      'therapist': widget.therapistName,
                    });
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Meeting scheduled for ${_selectedDay!.toLocal()} with ${widget.therapistName}!'),
                    ),
                  );
                }
              },
              child: const Text('Confirm Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

// Scheduled Meetings Dialog
class ScheduledMeetingsDialog extends StatelessWidget {
  const ScheduledMeetingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scheduled Meetings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Meeting with Dr Varghese Paul'),
                    subtitle: Text('Date: Jan 25, 2025'),
                  ),
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Meeting with Dr Amala Wilson'),
                    subtitle: Text('Date: Jan 30, 2025'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

// Help Line Page (unchanged)
class HelpLinePage extends StatelessWidget {
  const HelpLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Line'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Nasha Mukt Bharat Abhiyan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '14446',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduledMeetingsPage extends StatelessWidget {
  const ScheduledMeetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Meetings'),
      ),
      body: scheduledMeetings.isEmpty
          ? const Center(
              child: Text(
                'No meetings scheduled yet!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: scheduledMeetings.length,
              itemBuilder: (context, index) {
                final meeting = scheduledMeetings[index];
                return ListTile(
                  leading: const Icon(Icons.event),
                  title: Text('Meeting with ${meeting['therapist']}'),
                  subtitle: Text('Date: ${meeting['date']}'),
                );
              },
            ),
    );
  }
}

class HelplinePage extends StatelessWidget {
  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '14446');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _makePhoneCall,
        child: const Text('Call Helpline: 14446'),
      ),
    );
  }
}
