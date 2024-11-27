import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  IconData _getIconForCategory(Category category) {
    switch (category) {
      case Category.food:
        return Icons.fastfood;
      case Category.travel:
        return Icons.flight;
      case Category.leisure:
        return Icons.movie;
      case Category.work:
        return Icons.work;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  _getIconForCategory(expense.category),
                  size: 24,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat.yMd().format(expense.date),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
