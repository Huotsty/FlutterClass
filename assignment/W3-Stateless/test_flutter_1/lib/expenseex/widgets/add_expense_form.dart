import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseForm extends StatefulWidget {
  final Function(String, double, DateTime, Category) onAddExpense;

  const AddExpenseForm({required this.onAddExpense, super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.onAddExpense(
      enteredTitle,
      enteredAmount,
      _selectedDate,
      _selectedCategory,
    );

    Navigator.of(context).pop(); // Close the modal
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Picked Date: ${_selectedDate.toLocal()}'.split(' ')[0],
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: const Text('Choose Date'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}
