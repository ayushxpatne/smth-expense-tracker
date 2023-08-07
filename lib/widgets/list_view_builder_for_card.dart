import 'package:flutter/material.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';
import 'package:smth_prototype_2/widgets/expense_list_card.dart';

class ListViewOfCards extends StatelessWidget {
  const ListViewOfCards({
    super.key,
    required this.database,
    required this.onDismissingFunction,
  });

  final List<DataModel> database;
  final void Function(DataModel entryToBeDeleted) onDismissingFunction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: database.length,
      itemBuilder: ((context, index) {
        return Dismissible(
          resizeDuration: const Duration(seconds: 1),
          background: const ExpenseListCardBackgroundOnDismiss(),
          onDismissed: (direction) {
            onDismissingFunction(database[index]);
            
          },
          key: ValueKey(database[index]),
          child: ExpenseListCard(
            dataModel: database[index],
          ),
        );
      }),
    );
  }
}
