import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';

import '../enum/emotions.dart';
import '../enum/rabbia.dart';
import '../enum/paura.dart';
import '../enum/tristezza.dart';
import '../enum/disgusto.dart';
import '../enum/felicita.dart';
import '../enum/sorpresa.dart';
import 'note.dart';
import 'savedata.dart';
import 'utils.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //List<List<String>> tableData = [];
  List<Note> rows = [];

  @override
  void initState() {
    super.initState();
    _loadTableState();
  }

  void _loadTableState(){
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.loadTableState().then((tableData) {
      setState(() {
        rows = tableData.map((row) {
          dynamic temporarySecondaryEmotion;
          dynamic temporaryTertiaryEmotions;
          [temporarySecondaryEmotion, temporaryTertiaryEmotions] = emotionsFromRow(row[3], row[4], row[5]);
          return Note(
            antecedent: row[0],
            belief: row[1],
            consequence: row[2],
            emotion: Emotion.values.firstWhere((element) => element.toString() == row[3]),
            secondaryEmotion: temporarySecondaryEmotion,
            tertiaryEmotions: temporaryTertiaryEmotions,
            //currentPlace: row[6],
            currentDateTime: DateTime.parse(row[6])
          );
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antecedent, Belief, Consequence', style: TextStyle(
              fontSize: 19), textWidthBasis: TextWidthBasis.longestLine),
        backgroundColor: const Color.fromARGB(255, 179, 220, 245),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return FutureBuilder<List<List<String>>>(
            future: dataProvider.loadTableState(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // loading
              } else if (snapshot.hasError) {
                return const Text('Errore nel recupero dei dati'); // error handling
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('Nessun dato disponibile'); // error handling
              } else {
                List<List<String>> tableData = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tableData.map((row) {
                      dynamic temporarySecondaryEmotion;
                      dynamic temporaryTertiaryEmotions;
                      [temporarySecondaryEmotion, temporaryTertiaryEmotions] = emotionsFromRow(row[3], row[4], row[5]);
                      Note note = Note(
                        antecedent: row[0],
                        belief: row[1],
                        consequence: row[2],
                        emotion: Emotion.values.firstWhere((element) => element.toString() == row[3]),
                        secondaryEmotion: temporarySecondaryEmotion,
                        tertiaryEmotions: temporaryTertiaryEmotions,
                        //currentPlace: row[6],
                        currentDateTime: DateTime.parse(row[6])
                      );
                      return buildSingleRowTable(note);
                    }).toList(),
                  ),
                );
              }
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Aggiungi♡',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSingleRowTable(Note row) {
    return Card(
      color: const Color.fromARGB(255, 201, 230, 248),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onLongPress: () {
          _showModifyDeleteDialog(row);
        },
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Stato d\'animo ♡')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Tooltip(
                  message: row.antecedent,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Color.fromARGB(255, 150, 208, 245)),
                      children: <TextSpan>[
                        const TextSpan(text: 'Antecedent: ', style: TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
                        TextSpan(text: ' ${row.antecedent}', style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  )
                ))
              ],
            ),
            DataRow(
              cells: [
                DataCell(Tooltip(
                  message: row.belief,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Color.fromARGB(255, 150, 208, 245)),
                      children: <TextSpan>[
                        const TextSpan(text: 'Belief: ', style: TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
                        TextSpan(text: ' ${row.belief}', style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  )
                ))
              ],
            ),
            DataRow(
              cells: [
                DataCell(Tooltip(
                  message: row.consequence,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Color.fromARGB(255, 150, 208, 245)),
                      children: <TextSpan>[
                        const TextSpan(text: 'Consequence: ', style: TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
                        TextSpan(text: ' ${row.consequence}', style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  )
                ))
              ],
            ),
            DataRow(
              cells: [
                DataCell(buildEmotionCell(row.emotion, row.secondaryEmotion, row.tertiaryEmotions)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      //Text(row.currentPlace ?? ''),
                      //const SizedBox(width: 8),
                      Text(DateFormat('EEEE dd-MM-yyyy, HH:mm').format(row.currentDateTime), 
                                    style: const TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmotionCell(dynamic emotion, dynamic secondaryEmotion, dynamic tertiaryEmotions) {
    String emotionText = '';
    if (emotion == Emotion.nessuna) {
      emotionText = 'Nessuna emozione inserita';
      return Text(emotionText, style: const TextStyle(color: Color.fromARGB(255, 119, 187, 230)));
    } else if (secondaryEmotion == Nessuna.nessuna) {
      emotionText = '$emotion';
    } else if (tertiaryEmotions == Nessuna.nessuna) {
      emotionText = '$emotion, $secondaryEmotion';
    } else {
      emotionText = '$emotion, $secondaryEmotion, $tertiaryEmotions';
    }

    return Text.rich(TextSpan(
              style: const TextStyle(color: Color.fromARGB(255, 150, 208, 245)),
              children: <TextSpan>[
                const TextSpan(text: 'Emozione: ', style: TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
                TextSpan(text: emotionText, style: const TextStyle(color: Colors.black)),
              ],
            ),);
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
              
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        selectedEmotions = await _addEmotion(); 
                      },
                      child: const Text('Inserisci emozione'),
                  ),
                  const SizedBox(height: 10),
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
                      final dataProvider = Provider.of<DataProvider>(context, listen: false);
                      dataProvider.saveTableState(rows.map((row) 
                                                  => [row.antecedent, 
                                                  row.belief, 
                                                  row.consequence, 
                                                  row.emotion.toString(), 
                                                  row.secondaryEmotion.toString(), 
                                                  row.tertiaryEmotions.toString(),
                                                  //row.currentPlace,
                                                  row.currentDateTime
                                                  ]).toList());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Salva♡'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annulla'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _addLine(String antecedent, String belief, String consequence, dynamic emotion, 
    dynamic secondaryEmotion, dynamic selectedTertiaryEmotions) async{

    /*Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentPosition.latitude, currentPosition.longitude);
    String? currentPlace = placemarks.isNotEmpty ? placemarks[0].locality : '';*/
    DateTime currentDateTime = DateTime.now();
    setState(() {
      rows.add(Note(
        antecedent: antecedent,
        belief: belief,
        consequence: consequence,
        emotion: emotion,
        secondaryEmotion: secondaryEmotion,
        tertiaryEmotions: selectedTertiaryEmotions,
        //currentPlace: currentPlace,
        currentDateTime: currentDateTime
      ));
    });
  _loadTableState(); 
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
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        [selectedSecondaryEmotion, selectedTertiaryEmotion] = await _addSecondaryEmotionGivenPrimary(
                          selectedEmotion);
                        Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion, selectedTertiaryEmotion]);
                      },
                      child: const Text('Inserisci un altro livello di emozione'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop([selectedEmotion, selectedSecondaryEmotion, selectedTertiaryEmotion]);
                    },
                    child: const Text('Salva emozione ♡'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectedEmotion = Emotion.nessuna;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Non salvare questa emozione'),
                  ),
                ],
              ),
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
          ]),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      selectedTertiaryEmotion = await _addTertiaryEmotion(selectedEmotionIndex, tertiaryEmotionList);
                      Navigator.of(context).pop([selectedSecondaryEmotion, selectedTertiaryEmotion]);
                    },
                    child: const Text('Inserisci un altro livello di emozione'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectedTertiaryEmotion = Nessuna.values[0];
                      Navigator.of(context).pop([selectedSecondaryEmotion, selectedTertiaryEmotion]);
                    },
                    child: const Text('Salva emozioni ♡'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectedSecondaryEmotion = Nessuna.values[0];
                      Navigator.of(context).pop();
                    },
                    child: const Text('Non salvare questa emozione'),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
    return [selectedSecondaryEmotion, selectedTertiaryEmotion];
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
            Align(
              alignment: Alignment.centerRight,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(selectedTertiaryEmotion);
                    },
                    child: const Text('Salva tutti i livelli di emozione ♡'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectedTertiaryEmotion = Nessuna.values[0];
                      Navigator.of(context).pop();
                    },
                    child: const Text('Non salvare questa emozione'),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
    return selectedTertiaryEmotion;
  }

  void _showModifyDeleteDialog(Note row) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
          //title: const Text('Scegli azione'),
          actions: [
            Align(
              alignment: Alignment.center,
              child:Column(
                children: [
                  const SizedBox(height: 25),
                  /*ElevatedButton(
                    onPressed: () {
                      DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
                      dataProvider.modifyRowFromTableState(row);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Modifica♡'),
                  ),
                  const SizedBox(height: 10),*/
                  ElevatedButton(
                    onPressed: () {
                      DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
                      dataProvider.deleteRowFromTableState(row);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Elimina'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annulla'),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}