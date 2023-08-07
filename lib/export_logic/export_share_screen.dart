import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'dart:io';

void shareCSVScreen(String month, String year) async {
  Directory getDirectory = await getApplicationDocumentsDirectory();
  String dir = getDirectory.path;
  String fileName = '$month-$year-expenses.csv';
  String filePath = p.join(dir, fileName);

  await Share.shareXFiles([XFile(filePath)],
      subject: 'Expenses from $month, $year');
}

void shareExcelScreen(String month, String year) async {
  Directory getDirectory = await getApplicationDocumentsDirectory();
  String dir = getDirectory.path;
  String fileName = '$month-$year-expenses.xlsx';
  String filePath = p.join(dir, fileName);

  await Share.shareXFiles([XFile(filePath)],
      subject: 'Expenses from $month, $year');
}
