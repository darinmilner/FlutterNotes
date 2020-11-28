import 'package:flutter/material.dart';
import 'package:flutter_notes/models/Note.dart';

class NoteCollection extends ChangeNotifier {
  final List<Note> _notes = [
    Note(id: "1", body: "First Note"),
    Note(id: "2", body: "Second Note"),
  ];

  get allNotes => _notes;
  get count => _notes.length;

  Note getNotes(String id) {
    return _notes.where((note) => note.id == id).first;
  }

  void addNotes(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(String id, String body) {
    var currentNote = _notes.where((note) => note.id == id).first;
    currentNote.body = body;
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Note getNote(int index) {
    return _notes[index];
  }
}
