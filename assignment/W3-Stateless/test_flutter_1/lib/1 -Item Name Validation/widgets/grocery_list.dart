import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

enum FormMode {
  editing('Edit item', 'Edit'),
  adding('Add new item', 'Add');

  final String label;
  final String btnText;
  const FormMode(this.label, this.btnText);
}

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  Future<void> _addItem({ required FormMode mode, GroceryItem? item}) async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          mode: mode,
          item: item,
        ),
      ),
    );
    if (!context.mounted || newItem == null) return;
    setState(() {
      if (mode == FormMode.adding) {
        dummyGroceryItems.add(newItem!);
      } else if (mode == FormMode.editing) {
         final index = dummyGroceryItems.indexWhere((i) => i.id == newItem.id);
    if (index != -1) {
      dummyGroceryItems[index] = newItem; // Update the item
    }
      }
    });

 

  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
  content = ListView.builder(
    itemCount: dummyGroceryItems.length,
    itemBuilder: (ctx, index) => GroceryTile(
       dummyGroceryItems[index], // Provide the item to the GroceryTile
      edit: (mode, item) => _addItem(
        mode: FormMode.editing,
        item: dummyGroceryItems[index], // Pass the current item
      ),
      
    ),
  );
}
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => _addItem(mode: FormMode.adding),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(this.groceryItem, {super.key, required this.edit});
  final Function(FormMode mode, GroceryItem item) edit;
  final GroceryItem groceryItem;
  // final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => edit(FormMode.editing, groceryItem),
      title: Text(groceryItem.name),
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
    );
  }
}
