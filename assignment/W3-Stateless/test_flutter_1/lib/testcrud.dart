import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: CRUDExample()));
}

class CRUDExample extends StatefulWidget {
  const CRUDExample({super.key});

  @override
  State<CRUDExample> createState() => _CRUDExampleState();
}

class _CRUDExampleState extends State<CRUDExample> {
  final List<String> items = ["Task 1", "Task 2", "Task 3"];
  final TextEditingController controller = TextEditingController();

  // Add a new item
  void _addItem(String newItem) {
    setState(() {
      items.add(newItem);
    });
  }

  // Edit an existing item
  void _editItem(int index, String updatedItem) {
    setState(() {
      items[index] = updatedItem;
    });
  }

  // Delete an item
  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  // Show modal for adding/editing items
  void _showModal({String? initialValue, required Function(String) onSubmit}) {
    controller.text = initialValue ?? "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(initialValue == null ? "Add Task" : "Edit Task"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Task"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSubmit(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showModal(
              onSubmit: (value) {
                if (value.isNotEmpty) {
                  _addItem(value);
                }
              },
            ),
          ),
        ],
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        children: items
            .asMap()
            .entries
            .map(
              (entry) => ListTile(
                key: ValueKey(entry.key),
                title: Text(entry.value),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showModal(
                        initialValue: entry.value,
                        onSubmit: (updatedValue) {
                          if (updatedValue.isNotEmpty) {
                            _editItem(entry.key, updatedValue);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteItem(entry.key),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
