
import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import '../widgets/qcm_widget.dart';
import '../main.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC), 
  

      appBar: AppBar(
        title: const Text(
          'INTELLO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, fontStyle: FontStyle.italic, color: Colors.indigoAccent),
        ),
        centerTitle: false,
        elevation: 0,       
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        
  
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF), 
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'CP1 TEST L1',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6366F1), 
                ),
              ),
            ),
          ),
        ],
      ),
      

      body: FutureBuilder<Lesson>(
        future: loadLesson(),
        
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF6366F1)),
              ),
            );
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading lesson',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          }
          
          if (snapshot.hasData && snapshot.data!.activities.isNotEmpty) {
            final firstActivity = snapshot.data!.activities.first;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: firstActivity is QCMActivity
                  ? QCMWidget(activity: firstActivity)
                  : const Center(
                      child: Text('Activity Type Not Yet Implemented'),
                    ),
            );
          }

          return const Center(child: Text('No lesson data found.'));
        },
      ),
    );
  }
}
