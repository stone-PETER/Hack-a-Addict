import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/custom_scaffold.dart'; // Assuming CustomScaffold is in the widgets folder
import 'package:flutterapp/screens/allset.dart';  // Assuming AllSetPage is located in 'all_set_page.dart'
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ...



class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final TextEditingController _substanceController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _healthIssuesController = TextEditingController();
  final TextEditingController _emergenciesController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _concernsController = TextEditingController();

  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('Failed to initialize Firebase: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Create a GlobalKey to use the form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: ListView(
            children: [
              // Question 1: Substance
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         blurRadius: 8,
              //         spreadRadius: 2,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'What substances are you currently using?',
              //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(height: 10),
              //       TextFormField(
              //         controller: _substanceController,
              //         decoration: const InputDecoration(
              //           border: OutlineInputBorder(),
              //           filled: true,
              //           fillColor: Colors.white,
              //         ),
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please fill in this field';
              //           }
              //           return null;
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Question 2: Frequency
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How often do you use addictive substance (daily, weekly, occasionally)?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _frequencyController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Question 3: Duration
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How long have you been using this substance?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Question 4: Health Issues
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Have you noticed any physical or mental health issues related to your use?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _healthIssuesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Question 5: Medical Emergencies
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Have you ever had medical emergencies or overdoses due to substance use?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emergenciesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Question 6: Relationships
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How has your substance use affected your relationships with family or friends?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _relationshipController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Question 7: Concerns
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Do people in your life express concerns about your substance use?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _concernsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  // Validate the form
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      // Get Firestore instance
                      final FirebaseFirestore firestore = FirebaseFirestore.instance;
                      
                      // Create a document in 'questionnaires' collection
                      await firestore.collection('questionnaires').add({
                        'frequency': _frequencyController.text,
                        'duration': _durationController.text,
                        'healthIssues': _healthIssuesController.text,
                        'emergencies': _emergenciesController.text,
                        'relationship_affected': _relationshipController.text,
                        'concerns': _concernsController.text,
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      // Show success message
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Questionnaire submitted successfully!')),
                        );
                        
                        // Navigate to AllSet page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AllSetPage()),
                        );
                      }
                    } catch (e) {
                      // Show error message if submission fails
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error submitting form: $e')),
                        );
                      }
                    }
                  } else {
                    // Show validation error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all the fields.'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
