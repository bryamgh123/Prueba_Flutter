import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/operation.dart';
import 'package:flutter_application_1/models/note.dart';

class NotesState extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await Operation.notes();
    notifyListeners();
  }

  void toggleNoteCompletion(int index, bool completed) {
   //_notes[index].completed = completed;
    notifyListeners();
  }
}
