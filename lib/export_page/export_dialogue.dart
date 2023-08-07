import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:smth_prototype_2/export_logic/export_to_chosen_file.dart';
import 'global_month_year.dart';
import 'export_choose_month.dart';
import 'export_choose_year.dart';
import 'package:smth_prototype_2/export_logic/export_share_screen.dart';

class ExportDialogueContent extends StatefulWidget {
  const ExportDialogueContent({super.key, required this.database});

  final List<DataModel> database;

  @override
  State<ExportDialogueContent> createState() => _ExportDialogueContentState();
}

class _ExportDialogueContentState extends State<ExportDialogueContent> {
  final _formKey = GlobalKey<FormState>();

  void _onPressCSV() {
    _checkValid(_onPressCSVAfterValidation);
  }

  void _onPressCSVAfterValidation() {
    exportToCSV(
      widget.database,
      selectedMonth.toString(),
      selectedYear.toString(),
    );
    shareCSVScreen(selectedMonth.toString(), selectedYear.toString());
    Navigator.of(context).pop();
  }

  void _onPressExcel() {
    _checkValid(_onPressExcelAfterValidation);
  }

  void _onPressExcelAfterValidation() {
    exportToExcel(
      widget.database,
      selectedMonth.toString(),
      selectedYear.toString(),
    );
    shareExcelScreen(selectedMonth.toString(), selectedYear.toString());
    Navigator.of(context).pop();
  }

  void _checkValid(Function() runAfterValidation) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      runAfterValidation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 16,
              ),
              const ChooseMonth(),
              const SizedBox(
                height: 16,
              ),
              const ChooseYear(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Save As: '),
                  ElevatedButton(
                      onPressed: _onPressCSV, child: const Text('CSV')),
                  ElevatedButton(
                      onPressed: _onPressExcel, child: const Text('Excel')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
