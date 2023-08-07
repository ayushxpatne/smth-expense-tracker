import 'package:flutter/material.dart';
import 'package:smth_prototype_2/data_model/expense_list_data_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key, required this.onPressAddButton});

  final void Function(DataModel newExpense) onPressAddButton;

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  final _formKey = GlobalKey<FormState>();

  void _checkValid(Function() runAfterValidation) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      runAfterValidation();
    }
  }

  void _showDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onPressAddButton() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid ||
        _selectedDate == null ||
        _titleController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Invalid Input',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Please enter a valid value on title, amount or pick a date',
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('OK'))
              ],
            ),
          ),
        ),
      );
      return;
    }
    widget.onPressAddButton(
      DataModel(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
  }

  void _onPressAfterValidation() {
    _checkValid((_onPressAddButton));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pickDateButtonContentBefore = const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('pick date'),
        Icon(Icons.calendar_month_outlined),
      ],
    );

    Widget pickDateButtonContentAfter = Text(_selectedDate != null
        ? dateFormatter.format(_selectedDate!)
        : 'pick date');

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleText(),
              const SizedBox(
                height: 16,
              ),
              RoundTextField(
                title: 'title',
                titleController: _titleController,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: RoundTextField(
                      title: 'amount',
                      titleController: _amountController,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: DatePickerField(
                    content: _selectedDate == null
                        ? pickDateButtonContentBefore
                        : pickDateButtonContentAfter,
                    onTapShowDatePickerFunction: _showDatePicker,
                  )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField2(
                value: _selectedCategory,
                items: Category.values
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(e.name.toString()),
                            const SizedBox(
                              width: 28,
                            ),
                          ],
                        )))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(
                    () {
                      _selectedCategory = value;
                    },
                  );
                },
                hint: const Text(
                  'Select Month',
                  style: TextStyle(fontSize: 14),
                ),
                validator: (value) {
                  if (value == null) {
                    return '  Please Select Category';
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
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  errorStyle: const TextStyle(fontSize: 12, height: 0),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _onPressAfterValidation,
                    child: const Text(
                      'Add',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'new expense',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );
  }
}

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    super.key,
    required this.title,
    required this.titleController,
  });

  final TextEditingController titleController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        label: Text(title),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            )),
      ),
    );
  }
}

class DatePickerField extends StatelessWidget {
  const DatePickerField(
      {super.key,
      required this.onTapShowDatePickerFunction,
      required this.content});

  final void Function() onTapShowDatePickerFunction;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        height: ButtonTheme.of(context).height + 10,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: MaterialButton(
            elevation: 0,
            onPressed: onTapShowDatePickerFunction,
            child: content),
      ),
    );
  }
}
