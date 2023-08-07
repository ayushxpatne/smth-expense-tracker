import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';
//! for final build - currently save to files is not working on ios.
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';



void exportToExcel(List<DataModel> database, String month, String year) async {
  var excel = Excel.createExcel();
  var sheet = excel['Sheet1'];

  int numOfRows = database.length;

  for (int i = 0; i < numOfRows; i++) {
    String currentEntryMonth = database[i].getMonth;
    String currentEntryYear = database[i].getYear;
    if (currentEntryMonth.compareTo(month) == 0 &&
        currentEntryYear.compareTo(year) == 0) {
      sheet.appendRow(
        [
          database[i].title,
          database[i].amount,
          categoryNames[database[i].category],
          database[i].formattedDate,
        ],
      );
    }
  }
  //! check for andriod later
  Directory? tempDir = await getApplicationDocumentsDirectory();
  final tempPath = tempDir.path;
  String output = '$month-$year-expenses.xlsx';
  // String tempPath =
  //     '/Users/ayushpatne/Documents/Flutter/smth_prototype_2/lib/export/export-expenses.xlsx';
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(p.join(tempPath, output))
      // File(p.join(tempPath))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }
}

void exportToCSV(List<DataModel> database, String month, String year) async {
  List<String> header = [];
  List<List<String>> entries = [];
  int numOfRows = database.length;
  header.add('No.');
  header.add('User Name');
  header.add('Mobile');
  header.add('ID Number');

  for (int i = 0; i < numOfRows; i++) {
    String currentEntryMonth = database[i].getMonth;
    String currentEntryYear = database[i].getYear;

    if (currentEntryMonth.compareTo(month) == 0 &&
        currentEntryYear.compareTo(year) == 0) {
      entries.add(
        [
          database[i].title,
          database[i].amount.toString(),
          categoryNames[database[i].category].toString(),
          database[i].formattedDate,
        ],
      );
    }
  }

  Directory? getDir = await getApplicationDocumentsDirectory();
  final dir = getDir.path;
  String output = '$month-$year-expenses.csv';
  File outputFile = new File(p.join(dir, output));

  String csv = const ListToCsvConverter().convert(entries);

  outputFile.writeAsString(csv);
}
