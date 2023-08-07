import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 6, 105, 166)),
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
  List<List<String>> tableData = [];
  List<Note> rows = [];

  void _addLine(String antecedent, String belief, String consequence, dynamic emotion, dynamic secondaryEmotion) {
    setState(() {
      rows.add(Note(
        antecedent: antecedent,
        belief: belief,
        consequence: consequence,
        emotion: emotion,
        secondaryEmotion: secondaryEmotion
      ));
    });
  }

  Future<List<dynamic>> _addEmotion() async {
  Emotion selectedEmotion = Emotion.values[0];
  dynamic selectedSecondaryEmotion = Nessuna.values[0];

  final selectedEmotions = await showDialog<List<dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Inserisci emozione primaria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Emotion>(
                  value: selectedEmotion,
                  onChanged: (Emotion? newValue) {
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
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                selectedSecondaryEmotion = await _addSecondaryEmotion(selectedEmotion);
                Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion]);
              },
              child: const Text('Inserisci emozione secondaria'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion]);
            },
            child: const Text('Aggiungi'),
          ),
        ],
      );
    },
  );

  return selectedEmotions!;
}

  Future<dynamic> _addSecondaryEmotion(Emotion emotion) async{
    switch (emotion) {
      case Emotion.rabbia:
        return await _addRabbia();
      case Emotion.tristezza:
        return await _addTristezza();
      case Emotion.paura:
        return await _addPaura();
      case Emotion.disgusto:
        return await _addDisgusto();
      case Emotion.sorpresa:
        return await _addSorpresa();
      case Emotion.felicita:
        return await _addFelicita();
      case Emotion.nessuna:
        return await _addNessuna();
    }
  }

  Future<Rabbia> _addRabbia() async{
    Rabbia selectedSecondaryEmotion = Rabbia.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Rabbia>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Rabbia? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Rabbia.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Rabbia>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Tristezza> _addTristezza() async{
    Tristezza selectedSecondaryEmotion = Tristezza.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Tristezza>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Tristezza? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Tristezza.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Tristezza>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Paura> _addPaura() async{
    Paura selectedSecondaryEmotion = Paura.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<Paura>(
                value: selectedSecondaryEmotion,
                onChanged: (Paura? newValue) {
                  setState(() {
                    selectedSecondaryEmotion = newValue!;
                  });
                },
                items: Paura.values.map((secondaryEmotion) {
                  return DropdownMenuItem<Paura>(
                    value: secondaryEmotion,
                    child: Text(secondaryEmotion.toString()),
                  );
                }).toList(),
              );
              },
            ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Disgusto> _addDisgusto() async{
    Disgusto selectedSecondaryEmotion = Disgusto.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Disgusto>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Disgusto? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Disgusto.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Disgusto>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            )
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Sorpresa> _addSorpresa() async{
    Sorpresa selectedSecondaryEmotion = Sorpresa.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Sorpresa>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Sorpresa? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Sorpresa.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Sorpresa>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Felicita> _addFelicita() async{
    Felicita selectedSecondaryEmotion = Felicita.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Felicita>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Felicita? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Felicita.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Felicita>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            )
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<Nessuna> _addNessuna() async{
    Nessuna selectedSecondaryEmotion = Nessuna.values[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inserisci emozione secondaria'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<Nessuna>(
                  value: selectedSecondaryEmotion,
                  onChanged: (Nessuna? newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                    });
                  },
                  items: Nessuna.values.map((secondaryEmotion) {
                    return DropdownMenuItem<Nessuna>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            )
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),],
        );
      }
    );
    return selectedSecondaryEmotion;
  }

  Future<void> _saveTableState(List<List<String>> tableData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<String>> serializedTable = tableData.map((row) => row.toList()).toList();

    // save table state
    prefs.setStringList('tableData', serializedTable.map((row) => row.join(',')).toList());
  }

  void _showDialog() {
    String antecedent = '';
    String belief = '';
    String consequence = '';
    List<dynamic> selectedEmotions = [];
    dynamic selectedEmotion = Emotion.values[0];
    dynamic selectedSecondaryEmotion = Nessuna.values[0];

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
              ElevatedButton(
                onPressed: () async{
                  selectedEmotions = await _addEmotion(); 
                },
                child: const Text('Inserisci emozione primaria'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                    selectedEmotion = selectedEmotions[0];
                    selectedSecondaryEmotion = selectedEmotions[1];
                  });
                _addLine(antecedent, belief, consequence, selectedEmotion, selectedSecondaryEmotion);
                _saveTableState(rows.map((row) => [row.antecedent, row.belief, row.consequence, row.emotion.toString(), row.secondaryEmotion.toString()]).toList());
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
  void initState() {
    super.initState();
    _loadTableState();
  }

  Future<void> _loadTableState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedTable = prefs.getStringList('tableData');

    if (serializedTable != null) {
      setState(() {
        tableData = serializedTable.map((row) => row.split(',')).toList();
      });
    }
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
            DataColumn(label: SizedBox(width: 200, child: Text('Secondary emotion')), tooltip: 'emozione secondaria'),
          ],
          rows: rows.map((row) {
            return DataRow(
              cells: [
                DataCell(SizedBox(width: 300, child: Text(row.antecedent))),
                DataCell(SizedBox(width: 300, child: Text(row.belief))),
                DataCell(SizedBox(width: 300, child: Text(row.consequence))),
                DataCell(SizedBox(width: 200, child: Text(row.emotion.toString()))),
                DataCell(SizedBox(width: 200, child: Text(row.secondaryEmotion.toString()))),
              ],
            );
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add new line',
        child: const Icon(Icons.add),
      ),
    );
  }
}
