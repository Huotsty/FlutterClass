import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ListScreen()));
}

// Enum for Categories
enum Category { travel, shopping, food }

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.travel:
        return "Travel";
      case Category.shopping:
        return "Shopping";
      case Category.food:
        return "Food";
    }
  }

  Icon get icon {
    switch (this) {
      case Category.travel:
        return const Icon(Icons.flight, color: Colors.green);
      case Category.shopping:
        return const Icon(Icons.shopping_cart, color: Colors.blue);
      case Category.food:
        return const Icon(Icons.restaurant, color: Colors.red);
    }
  }
}

// Enum for Form Mode
enum FormMode { adding, editing }

// Model for Item
class Item {
  String title;
  double amount;
  Category category;

  Item({required this.title, required this.amount, required this.category});
}

// List Screen
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<Item> items = [
    Item(title: 'travel', amount: 12, category: Category.food),
  ];

  // Navigate to Add/Edit Screen
  void _navigateToFormScreen({Item? item, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          mode: item == null ? FormMode.adding : FormMode.editing,
          item: item,
        ),
      ),
    );

    if (result != null && result is Item) {
      setState(() {
        if (index != null) {
          items[index] = result; // Edit
        } else {
          items.add(result); // Add
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD Example")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: item.category.icon,
            title: Text(item.title),
            subtitle: Text("\$${item.amount.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _navigateToFormScreen(item: item, index: index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToFormScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Form Screen
class FormScreen extends StatefulWidget {
  final FormMode mode;
  final Item? item;

  const FormScreen({super.key, required this.mode, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.mode == FormMode.editing && widget.item != null) {
      _titleController.text = widget.item!.title;
      _amountController.text = widget.item!.amount.toString();
      _selectedCategory = widget.item!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.mode == FormMode.editing;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Item" : "Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an amount";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        category.icon,
                        const SizedBox(width: 8),
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) {
                  if (value == null) {
                    return "Please select a category";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          Item(
                            title: _titleController.text,
                            amount: double.parse(_amountController.text),
                            category: _selectedCategory!,
                          ),
                        );
                      }
                    },
                    child: Text(isEditing ? "Save Changes" : "Add Item"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
