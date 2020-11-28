import 'package:flutter/material.dart';
import 'package:flutter_notes/models/Note.dart';
import 'package:flutter_notes/providers/NoteCollection.dart';
import 'package:flutter_notes/screens/NoteScreen.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  var collection = NoteCollection();
  var uuid = new Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            if (notes.count == 0) {
              return Text("Notes");
            }
            return Text("Notes ${notes.count}");
          },
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: _buildNotesList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Note note = Note(
            id: uuid.v4(),
          );
          debugPrint(note.id.toString());
          Provider.of<NoteCollection>(context, listen: false).addNotes(note);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(note: note),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotesList() {
    return Consumer<NoteCollection>(
      builder: (context, notes, child) {
        var allNotes = notes.allNotes;

        if (allNotes.length == 0) {
          return Center(
            child: Text("No Notes"),
          );
        }
        return ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            var note = allNotes[index];

            return Dismissible(
              key: Key(note.id),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (d) {
                Provider.of<NoteCollection>(context, listen: false)
                    .deleteNote(note.id);
              },
              child: ListTile(
                title: Text(note.noteBody),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: note,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
