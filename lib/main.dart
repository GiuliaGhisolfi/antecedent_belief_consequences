import 'package:flutter/material.dart';

import 'enum/emotions.dart';
import 'note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 24, 61, 109)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> rows = [];

  void _addLine(String antecedent, String belief, String consequence, Emotion emotion) {
  setState(() {
    rows.add(Note(
      antecedent: antecedent,
      belief: belief,
      consequence: consequence,
      emotion: emotion
    ));
  });
  }

  void _showDialog() {
  String antecedent = '';
  String belief = '';
  String consequence = '';
  Emotion selectedEmotion = Emotion.values[0];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Inserisci il tuo stato d\'animo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => antecedent = value,
              decoration: const InputDecoration(labelText: 'Antecedent: stimolo di partenza'),
            ),
            TextField(
              onChanged: (value) => belief = value,
              decoration: const InputDecoration(labelText: 'Belief: pensiero, convinzione per valutare lo stimolo di partenza'),
            ),
            TextField(
              onChanged: (value) => consequence = value,
              decoration: const InputDecoration(labelText: 'Consequence: emozioni, comportamenti, reazioni'),
            ),
            DropdownButton<Emotion>(
              value: selectedEmotion, 
              onChanged: (newValue) {
                setState(() {
                  selectedEmotion = newValue!;
                });
              },
              items: Emotion.values.map((emotion) {
                return DropdownMenuItem<Emotion>(
                  value: emotion,
                  child: Text(emotion.toString()),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _addLine(antecedent, belief, consequence, selectedEmotion);
              Navigator.of(context).pop();
            },
            child: const Text('Aggiungi'),
          ),
        ],
      );
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABC: Antecedent, Belief, Consequence'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: SizedBox(width: 300, child: Text('Antecedent')), tooltip: 'stimolo di partenza'),
            DataColumn(label: SizedBox(width: 300, child: Text('Belief')), tooltip: 'pensiero, convinzione per valutare lo stimolo di partenza'),
            DataColumn(label: SizedBox(width: 300, child: Text('Consequence')), tooltip: 'emozioni, comportamenti, reazioni'),
            DataColumn(label: SizedBox(width: 200, child: Text('Primary emotion')), tooltip: 'emozione primaria'),
          ],
          rows: rows.map((row) {
            return DataRow(
              cells: [
                DataCell(SizedBox(width: 200, child: Text(row.antecedent))),
                DataCell(SizedBox(width: 200, child: Text(row.belief))),
                DataCell(SizedBox(width: 200, child: Text(row.consequence))),
                DataCell(SizedBox(width: 200, child: Text(row.emotion.toString()))),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
