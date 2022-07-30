import 'first_page.dart';

import 'tests.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = DateFormat('dd.MM');
String formattedDate = formatter.format(now);
var formatter2 = DateFormat('dd MMM yyyy');
String formattedDate4 = formatter2.format(now);

class Session {
  final page;
  final note, time, date;
  Session({
    required this.page,
    required this.note,
    required this.time,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'note': bNoteController.text.trim(),
        'time': duration,
        'date': formattedDate4,
      };

  static Session fromJson(Map<String, dynamic> json) => Session(
      page: json['ePage'],
      note: json['note'],
      time: json['time'],
      date: json['date']);
}

class PageTimeCounter {
  final page, time;
  PageTimeCounter({
    required this.page,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'time': duration,
      };

  static PageTimeCounter fromJson(Map<String, dynamic> json) => PageTimeCounter(
        page: json['page'],
        time: json['time'],
      );
}

class Test {
  final String title, correctCount, wrongCount, blankCount, note, date;
  Test({
    required this.title,
    required this.correctCount,
    required this.wrongCount,
    required this.blankCount,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'title': currentCollection,
        'correctCount': tCorrectCountController.text.trim(),
        'wrongCount': tWrongCountController.text.trim(),
        'blankCount': tBlankCountController.text.trim(),
        'note': tNoteController.text.trim(),
        'date': formattedDate,
      };

  static Test fromJson(Map<String, dynamic> json) => Test(
      title: json['title'],
      correctCount: json['correctCount'],
      wrongCount: json['wrongCount'],
      blankCount: json['blankCount'],
      note: json['note'],
      date: json['date']);
}

class Task {
  final String title, description, date;
  final bool isCompleted;
  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'taskTitle': taskTitle.text.trim(),
        'taskDescription': taskDescription.text.trim(),
        'isCompleted': false,
        'date': formattedDate,
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
      title: json['taskTitle'],
      description: json['taskDescription'],
      isCompleted: json['isCompleted'],
      date: json['date']);
}
