# Intello CP1 - Quiz App

A offline quiz app for primary school learners.

## Features
✅ Loads lessons from JSON  
✅ Multiple choice questions  
✅ Shows if answers are correct/incorrect  
✅ Works offline  

## How to Run

```bash
flutter pub get
flutter run
```

## Build Apk File
```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── main.dart              # App start
├── models/lesson_model.dart    # Data
├── screens/lesson_screen.dart  # Main UI
└── widgets/qcm_widget.dart     # Questions
```