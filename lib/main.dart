import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'enum/emotions.dart';
import 'enum/rabbia.dart';
import 'enum/paura.dart';
import 'enum/tristezza.dart';
import 'enum/disgusto.dart';
import 'enum/felicita.dart';
import 'enum/sorpresa.dart';
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

  void _addLine(String antecedent, String belief, String consequence, dynamic emotion, 
    dynamic secondaryEmotion, dynamic selectedTertiaryEmotions) {
    setState(() {
      rows.add(Note(
        antecedent: antecedent,
        belief: belief,
        consequence: consequence,
        emotion: emotion,
        secondaryEmotion: secondaryEmotion,
        selectedTertiaryEmotions: selectedTertiaryEmotions
      ));
    });
  }

  Future<List<dynamic>> _addEmotion() async {
    Emotion selectedEmotion = Emotion.values[0];
    dynamic selectedSecondaryEmotion = Nessuna.values[0];
    dynamic selectedTertiaryEmotion = Nessuna.values[0];

    final selectedEmotions = await showDialog<List<dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 250),
          title: const Text('Inserisci emozione'),
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  [selectedSecondaryEmotion, selectedTertiaryEmotion] = await _addSecondaryEmotionGivenPrimary(
                    selectedEmotion);
                  Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion, selectedTertiaryEmotion]);
                },
                child: const Text('Inserisci un altro livello di emozione'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion, selectedTertiaryEmotion]);
              },
              child: const Text('Salva emozione'),
            ),
          ],
        );
      },
    );

    return selectedEmotions!;
  }

  Future<List<dynamic>> _addSecondaryEmotionGivenPrimary(Emotion emotion) async{
    List<dynamic> secondaryEmotionList = [];
    List<dynamic> tertiaryEmotionList = [];

    switch (emotion) {
      case Emotion.rabbia:
        secondaryEmotionList = Rabbia.values;
        tertiaryEmotionList = RabbiaAssociated.values;
      case Emotion.tristezza:
        secondaryEmotionList = Tristezza.values;
        tertiaryEmotionList = TristezzaAssociated.values;
      case Emotion.paura:
        secondaryEmotionList = Paura.values;
        tertiaryEmotionList = PauraAssociated.values;
      case Emotion.disgusto:
        secondaryEmotionList = Disgusto.values;
        tertiaryEmotionList = DisgustoAssociated.values;
      case Emotion.sorpresa:
        secondaryEmotionList = Sorpresa.values;
        tertiaryEmotionList = SorpresaAssociated.values;
      case Emotion.felicita:
        secondaryEmotionList = Felicita.values;
        tertiaryEmotionList = FelicitaAssociated.values;
      case Emotion.nessuna:
        secondaryEmotionList = Nessuna.values;
        tertiaryEmotionList = NessunaAssociated.values;
    }
    return await _addSecondaryEmotion(secondaryEmotionList, tertiaryEmotionList);
  }

  Future<List<dynamic>> _addSecondaryEmotion(List<dynamic> secondaryEmotionList, List<dynamic> tertiaryEmotionList) async{
    dynamic selectedSecondaryEmotion = secondaryEmotionList[0];
    dynamic selectedTertiaryEmotion = tertiaryEmotionList[0];
    int selectedEmotionIndex = 0;

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: const Text('Inserisci emozione'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<dynamic>(
                  value: selectedSecondaryEmotion,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      selectedSecondaryEmotion = newValue!;
                      selectedEmotionIndex = secondaryEmotionList.indexOf(selectedSecondaryEmotion);
                    });
                  },
                  items: secondaryEmotionList.map((secondaryEmotion) {
                    return DropdownMenuItem<dynamic>(
                      value: secondaryEmotion,
                      child: Text(secondaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  selectedTertiaryEmotion = await _addTertiaryEmotion(selectedEmotionIndex, tertiaryEmotionList);
                  Navigator.of(context).pop([selectedSecondaryEmotion, selectedTertiaryEmotion]);
                },
                child: const Text('Inserisci un altro livello di emozione'),
              ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop([selectedSecondaryEmotion, selectedTertiaryEmotion]);
              },
              child: const Text('Salva emozioni'),
            ),],
        );
      }
    );
    return [selectedSecondaryEmotion, selectedTertiaryEmotion];
  }

  List<dynamic> getSelectableTertiaryEmotions(
    int selectedEmotionIndex , List<dynamic> tertiaryEmotionList
    ) {
    final List<dynamic> selectableTertiaryEmotions = [];

    selectableTertiaryEmotions.add(tertiaryEmotionList[selectedEmotionIndex * 2]);
    selectableTertiaryEmotions.add(tertiaryEmotionList[selectedEmotionIndex * 2 + 1]);

    return selectableTertiaryEmotions;
  } 

  Future<dynamic> _addTertiaryEmotion(int selectedEmotionIndex, List<dynamic> tertiaryEmotionList) async{
    List<dynamic> selectableTertiaryEmotions = getSelectableTertiaryEmotions(
                      selectedEmotionIndex, tertiaryEmotionList);
    dynamic selectedTertiaryEmotion = selectableTertiaryEmotions[0];

    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
          title: const Text('Inserisci emozione'),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ 
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<dynamic>(
                  value: selectedTertiaryEmotion,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      selectedTertiaryEmotion = newValue!;
                    });
                  },
                  items: selectableTertiaryEmotions.map((tertiaryEmotion) {
                    return DropdownMenuItem<dynamic>(
                      value: tertiaryEmotion,
                      child: Text(tertiaryEmotion.toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(selectedTertiaryEmotion);
              },
              child: const Text('Inserisci e salva tutti i livelli di emozione'),
            ),],
        );
      }
    );
    return selectedTertiaryEmotion;
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
    dynamic selectedTertiaryEmotions = Nessuna.values[0];

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
                decoration: const InputDecoration(labelText: 'Belief: pensiero, convinzione'),
              ),
              TextField(
                onChanged: (value) => consequence = value,
                decoration: const InputDecoration(labelText: 'Consequence: emozioni'),
              ),
              const SizedBox(height: 10), // add an empty space
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async{
                  selectedEmotions = await _addEmotion(); 
                },
                child: const Text('Inserisci emozione'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedEmotions.isNotEmpty) {
                  setState(() {
                      selectedEmotion = selectedEmotions[0];
                      selectedSecondaryEmotion = selectedEmotions[1];
                      selectedTertiaryEmotions = selectedEmotions[2];
                    });
                }
                _addLine(antecedent, belief, consequence, selectedEmotion, selectedSecondaryEmotion, selectedTertiaryEmotions);
                _saveTableState(rows.map((row) => [row.antecedent, row.belief, row.consequence, row.emotion.toString(), 
                  row.secondaryEmotion.toString(), row.selectedTertiaryEmotions.toString()]).toList());
                Navigator.of(context).pop();
              },
              child: const Text('Salva♡'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTableState().then((tableData) {
      setState(() {
        rows = tableData.map((row) {
          return Note(
            antecedent: row[0],
            belief: row[1],
            consequence: row[2],
            emotion: Emotion.values.firstWhere((element) => element.toString() == row[3]),
            secondaryEmotion: Emotion.values.firstWhere((element) => element.toString() == row[4]),
            selectedTertiaryEmotions: Emotion.values.firstWhere((element) => element.toString() == row[5])
          );
        }).toList();
      });
    });
  }

  Future<List<List<String>>> _loadTableState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedTable = prefs.getStringList('tableData');

    // return previously table state (if not null)
    if (serializedTable != null) {
      List<List<String>> tableData = serializedTable.map((row) => row.split(',')).toList();
      return tableData;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antecedent, Belief, Consequence', style: TextStyle(
              fontSize: 19), textWidthBasis: TextWidthBasis.longestLine),
        backgroundColor: const Color.fromARGB(255, 129, 199, 243),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Antecedent'), tooltip: 'stimolo di partenza'),
            DataColumn(label: Text('Belief'), tooltip: 'pensiero, convinzione per valutare lo stimolo di partenza'),
            DataColumn(label: Text('Consequence'), tooltip: 'emozioni, comportamenti, reazioni'),
            DataColumn(label: Text('Primary emotion'), tooltip: 'emozione primaria'),
            DataColumn(label: Text('Secondary emotion'), tooltip: 'emozione secondaria'),
            DataColumn(label: Text('Tertiary emotion'), tooltip: 'emozione terziaria'),
          ],
          rows: rows.map((row) {
            return DataRow(
              cells: [
                DataCell(Text(row.antecedent)),
                DataCell(Text(row.belief)),
                DataCell(Text(row.consequence)),
                DataCell(Text(row.emotion.toString())),
                DataCell(Text(row.secondaryEmotion.toString())),
                DataCell(Text(row.selectedTertiaryEmotions.toString())),
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
