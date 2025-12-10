
class Lesson {
  final String id;        
  final String title;     
  final List<Activity> activities; 

  Lesson({required this.id, required this.title, required this.activities});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(

      id: json['id'] as String,
      title: json['title'] as String,
      
      activities: (json['activities'] as List<dynamic>)
          .map((item) => Activity.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

abstract class Activity {
  final String type;    
  final String question; 

  Activity({required this.type, required this.question});

  factory Activity.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'qcm':
        return QCMActivity.fromJson(json);
      
      default:
        throw FormatException('Unknown activity type: ${json['type']}');
    }
  }
}

class QCMActivity extends Activity {
  final List<String> options; 
  final String answer;        

  QCMActivity({
    required super.question, 
    required this.options,
    required this.answer,
  }) : super(type: 'qcm');


  factory QCMActivity.fromJson(Map<String, dynamic> json) {
    return QCMActivity(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      answer: json['answer'] as String,
    );
  }
}