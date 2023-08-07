import 'package:flutter/material.dart';
import 'global_month_year.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';

class ChooseMonth extends StatefulWidget {
  const ChooseMonth({
    super.key,

  });

  @override
  State<ChooseMonth> createState() => _ChooseMonthState();
}

class _ChooseMonthState extends State<ChooseMonth> {
  String? _monthSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: _monthSelected,
      items: monthList
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item.toString()),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _monthSelected = value;
          selectedMonth = _monthSelected;
        });
      },
      hint: const Text(
        'Select Month',
        style: TextStyle(fontSize: 14),
      ),
      validator: (value) {
        if (value == null) {
          return '  Please Select Month';
        }
        return null;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.primary,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12, height: 0),
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
    );
  }
}