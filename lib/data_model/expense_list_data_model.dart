import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMMMEd('en_US');
final getMonthFromDateFormatter = DateFormat.MMMM();
final getYearFromDateFormatter = DateFormat.y();

int endYear = DateTime.now().year;
int startYear = 2023;
List yearList = Iterable<int>.generate((endYear + 1))
    .skip(startYear)
    .toList()
    .reversed
    .toList()
    .map((e) => e.toString())
    .toList();

List<String> monthList = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

//declaring enum for categories
enum Category {
  food,
  leisure,
  work,
  travel,
}

//declaring icons
const categoryNames = {
  Category.work: "Work",
  Category.food: "Food",
  Category.leisure: "Leisure",
  Category.travel: "Travel",
};

class DataModel {
  //declare variables
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  DataModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }

  String get getMonth {
    return getMonthFromDateFormatter.format(date);
  }

  String get getYear {
    return getYearFromDateFormatter.format(date);
  }
}
