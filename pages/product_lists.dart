import 'package:cloud_firestore/cloud_firestore.dart';
import '/pages/dialog2.dart';
import '/pages/notes.dart';
import '/pages/private.dart';
import '/pages/arabic.dart';
import '/pages/edit_notes.dart';
import 'first_page.dart';





class Note {
  final String title, topic, description;
  Note({
    required this.title,
    required this.topic,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': titleController.text.trim(),
        'topic': topicController.text.trim(),
        'description': descriptionController.text.trim(),
      };

  static Note fromJson(Map<String, dynamic> json) => Note(
      title: json['title'],
      topic: json['topic'],
      description: json['description']);
}

List<Note> notes = [
  Note(title: 'DocBook', topic: 'Medical', description: 'hey')
];

class Words {
  final String word, meaning,  type,sentence;
  Words({
    required this.word,
    required this.meaning,
    required this.type,
    required this.sentence,
  });

  Map<String, dynamic> toJson() => {
        'word': wordController3.text.trim(),
        'meaning': meaningController3.text.trim(),

        'type': wordCategorie,
        'sentence': sentenceController.text.trim(),
      };

  static Words fromJson(Map<String, dynamic> json) => Words(
        word: json['title'],
        meaning: json['topic'],
        type: json['type'],

        sentence: json['sentence'],
      );
}

List<Words> words = [
  Words(word: 'DocBook', meaning: 'Medical',type:wordCategorie, sentence: 'hey')
];



class Todo2 {
  final String todo;
  final DocumentSnapshot snapshotData;
  Todo2({
    required this.todo,
    required this.snapshotData
  }
  
  );

  Map<String, dynamic> toJson() => {
        'todo': snapshotData['todo'],
      };

  static Todo2 fromJson(Map<String, dynamic> json) => Todo2(
        todo: json['todo'],
        snapshotData: json['']
      );
}

class Todo3 {
  final String todo;
  final DocumentSnapshot snapshotData;
  Todo3({
    required this.todo,
    required this.snapshotData
  }
  
  );

  Map<String, dynamic> toJson() => {
        'todo': snapshotData['todo'],
      };

  static Todo3 fromJson(Map<String, dynamic> json) => Todo3(
        todo: json['todo'],
        snapshotData: json['']
      );
}