import 'package:flutter/material.dart';
import 'package:flutter_notes/providers/NoteCollection.dart';
import 'package:flutter_notes/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        child: MyApp(),
        create: (context) => NoteCollection(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      home: HomeScreen(),
    );
  }
}
