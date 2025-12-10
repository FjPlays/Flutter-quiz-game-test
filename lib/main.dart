
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'models/lesson_model.dart'; 
import 'screens/lesson_screen.dart'; 

Future<Lesson> loadLesson() async {
  try {
    final jsonString = await rootBundle.loadString('assets/data/cp1_test_l1.json');
  
    final jsonMap = json.decode(jsonString);
    
    return Lesson.fromJson(jsonMap as Map<String, dynamic>);
  } catch (e) {

    print('Error parsing JSON: $e');
    rethrow;
  }
}

void main() {
  runApp(const IntelloApp());
}

class IntelloApp extends StatelessWidget {
  const IntelloApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intello',
      debugShowCheckedModeBanner: false, 
      
      theme: ThemeData(
        useMaterial3: true, 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), 
          brightness: Brightness.light,
        ),
    
        scaffoldBackgroundColor: const Color(0xFFFAFAFC), 
        
  
        appBarTheme: const AppBarTheme(
          elevation: 0, 
          backgroundColor: Color(0xFFFAFAFC), 
          foregroundColor: Color(0xFF1F2937), 
          surfaceTintColor: Colors.transparent, 
        ),
        
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1), 
          ),
          color: Colors.white, 
        ),
        
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800, 
            color: Color(0xFF1F2937), 
            letterSpacing: -0.5, 
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151), 
            height: 1.6, 
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white, 
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      home: const LessonScreen(), 
    );
  }
}