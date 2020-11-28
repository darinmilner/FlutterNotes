import 'package:flutter/material.dart';
import 'package:flutter_notes/models/Note.dart';
import 'package:flutter_notes/providers/NoteCollection.dart';
import "package:provider/provider.dart";

class NoteScreen extends StatefulWidget {
  final Note _note;
  NoteScreen({Key key, note}) : _note = note;
  @override
  _NoteScreenState createState() => _NoteScreenState(note: _note);
}

class _NoteScreenState extends State<NoteScreen> {
  final Note _note;
  _NoteScreenState({Key key, note}) : _note = note;

  final TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();

    bodyController.text = _note.body;
    bodyController.addListener(() {
      Provider.of<NoteCollection>(context, listen: false)
          .updateNote(_note.id, bodyController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            return Text(
              notes.getNotes(_note.id).noteBody,
            );
          },
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Enter new note here",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
              ),
              padding: EdgeInsets.all(20.0),
              child: Consumer<NoteCollection>(
                builder: (context, notes, child) {
                  Note note = notes.getNotes(_note.id);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${note.characters} characters",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${note.words} words",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
