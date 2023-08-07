import 'package:flutter/material.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';

class ExpenseListCard extends StatelessWidget {
  const ExpenseListCard({
    super.key,
    required this.dataModel,
  });

  final DataModel dataModel;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataModel.title),
                  Text(categoryNames[dataModel.category]!),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(dataModel.amount.toString()),
                  Text(dataModel.formattedDate),
                ],
              )
            ],
          ),
        ));
  }
}

class ExpenseListCardBackgroundOnDismiss extends StatelessWidget {
  const ExpenseListCardBackgroundOnDismiss({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Deleted',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer),
          ),
        ),
      ),
    );
  }
}
