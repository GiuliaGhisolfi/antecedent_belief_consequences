import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class DataProvider extends ChangeNotifier {

  Future<void> saveTableState(List<List<Object>> newTableData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<Object>> serializedTable = newTableData.map((row) => row.toList()).toList();

    // save table state
    prefs.setStringList('tableData', serializedTable.map((row) => row.join(',')).toList());
    notifyListeners();
  }

  Future<List<List<String>>> loadTableState() async {
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

  Future<void> deleteRowFromTableState(Note row) async {
    List rowList = rowToList(row);
    List<List<String>> tableData = await loadTableState();
    tableData.removeWhere((rows) => listEquals(rows, rowList));
    await saveTableState(tableData);
    // wait for save to complete
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}

List rowToList(Note row) {
  return [row.antecedent, 
          row.belief, 
          row.consequence, 
          row.emotion.toString(), 
          row.secondaryEmotion.toString(), 
          row.tertiaryEmotions.toString(),
          //row.currentPlace,
          row.currentDateTime.toString()
          ];
}
