import 'package:flutter/material.dart';
import 'global_month_year.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';

class ChooseYear extends StatefulWidget {
  const ChooseYear({super.key,});


  @override
  State<ChooseYear> createState() => _ChooseYearState();
}

class _ChooseYearState extends State<ChooseYear> {
  String? _yearSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: _yearSelected,
      items: yearList
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item.toString()),
            ),
          )
          .toList(),

      //*__________________________________________________
      onChanged: (value) {
        setState(() {
          _yearSelected = value.toString();
          selectedYear = _yearSelected;
        });
      },
      //*__________________________________________________
      hint: const Text(
        'Select Year',
        style: TextStyle(fontSize: 14),
      ),
      validator: (value) {
        if (value == null) {
          return '  Please Select Year';
        }
        return null;
      },
      //*__________________________________________________
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
      //*__________________________________________________
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        enabled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
      ),
    );
  }
}
