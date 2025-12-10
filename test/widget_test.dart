
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_game_app/main.dart';

void main() {

  testWidgets(
    'QCM Widget: User selects correct answer and sees success', 
    (WidgetTester tester) async {
      await tester.pumpWidget(const IntelloApp());
      await tester.pumpAndSettle(); 
      expect(find.text('What is 2 + 2?'), findsOneWidget);
      await tester.tap(find.text('4'));
      await tester.pump(); 
      print('✅ User tapped option "4"');
      expect(find.text('Check Answer'), findsOneWidget);
      print('✅ "Check Answer" button is visible');
      await tester.tap(find.text('Check Answer'));
      await tester.pumpAndSettle(); 
      print('✅ User clicked "Check Answer"');
      expect(find.text('Continue to Next Question!'), findsOneWidget);
      print('✅ "Continue to Next Question" button appeared (correct answer!)');
  });

  testWidgets(
    'QCM Widget: User selects wrong answer and sees retry option', 
    (WidgetTester tester) async {
      
      await tester.pumpWidget(const IntelloApp());
      await tester.pumpAndSettle();
      expect(find.text('What is 2 + 2?'), findsOneWidget);
      print('✅ Question loaded');


      await tester.tap(find.text('3'));
      await tester.pump(); 
      print('✅ User tapped wrong option "3"');

      await tester.tap(find.text('Check Answer'));
      await tester.pumpAndSettle(); 
      print('✅ User clicked "Check Answer"');

      expect(find.text('Try Again'), findsOneWidget);
      
      expect(find.text('Not quite right. Try again!'), findsOneWidget);
      print('✅ Error feedback displayed (wrong answer!)');

      await tester.tap(find.text('Try Again'));
      await tester.pumpAndSettle();
      print('✅ User clicked "Try Again"');

      expect(find.text('Check Answer'), findsOneWidget);
    
      expect(find.text('Not quite right. Try again!'), findsNothing);
      print('✅ Quiz reset for retry');
  });
}