import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {

  Future<void> saveTableState(List<List<Object>> tableData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<Object>> serializedTable = tableData.map((row) => row.toList()).toList();

    // save table state
    prefs.setStringList('tableData', serializedTable.map((row) => row.join(',')).toList());

    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  Future<List<List<String>>> loadTableState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedTable = prefs.getStringList('tableData');
    await Future.delayed(const Duration(seconds: 1));

    // return previously table state (if not null)
    if (serializedTable != null) {
      List<List<String>> tableData = serializedTable.map((row) => row.split(',')).toList();
      return tableData;
    } else {
      return [];
    }
  } 
}
