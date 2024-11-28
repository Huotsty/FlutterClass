import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../widgets/add_expense_form.dart';
import '../widgets/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

   // Method to add a new expense
  void _addExpense(String title, double amount, DateTime date, Category category) {
    final newExpense = Expense(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  // Method to open the modal
  void _openAddExpenseModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: AddExpenseForm(onAddExpense: _addExpense),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions:  [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _openAddExpenseModal(context),
              ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text(' Expenses App'),
      ),
      body: ExpensesList(expenses: _registeredExpenses),
    );
  }
}



