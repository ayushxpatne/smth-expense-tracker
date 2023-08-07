import 'package:flutter/material.dart';
import 'package:smth_prototype_2/add_expense_page.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';
import 'package:smth_prototype_2/export_page/export_dialogue.dart';
import 'package:smth_prototype_2/widgets/list_view_builder_for_card.dart';

class ExpensesHomeScreen extends StatefulWidget {
  const ExpensesHomeScreen({super.key});

  @override
  State<ExpensesHomeScreen> createState() => _ExpensesHomeScreenState();
}

class _ExpensesHomeScreenState extends State<ExpensesHomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> fadeAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 0),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<DataModel> database = [
    DataModel(
        title: 'title',
        amount: 100,
        date: DateTime.now(),
        category: Category.food),
    DataModel(
        title: 'title 2',
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addToDatabase(DataModel newExpenseEntry) {
    setState(() {
      database.add(newExpenseEntry);
    });
    Navigator.of(context).pop();
  }

  void _removeFromDatabase(DataModel entryToBeDeleted) {
    int indexOfRemovedExpense = database.indexOf(entryToBeDeleted);
    setState(() {
      database.remove(entryToBeDeleted);
    });

    var snackBar = SnackBar(
      content: const Text("Expense Deleted"),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              database.insert(indexOfRemovedExpense, entryToBeDeleted);
            });
          }),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onPressAddExpenseButton() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddExpensePage(
            onPressAddButton: _addToDatabase,
          );
        });
  }

  void _onPressExportButton() {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              child: ExportDialogueContent(
                database: database,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Records Found"),
    );
    if (database.isNotEmpty) {
      mainContent = ListViewOfCards(
        database: database,
        onDismissingFunction: _removeFromDatabase,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('smth'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onPressAddExpenseButton,
          ),
          IconButton(
              onPressed: _onPressExportButton,
              icon: const Icon(Icons.ios_share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainContent,
      ),
    );
  }
}
