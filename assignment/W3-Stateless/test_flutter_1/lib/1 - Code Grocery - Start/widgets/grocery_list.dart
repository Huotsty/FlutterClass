import 'package:flutter/material.dart';
import 'package:test_flutter_1/1%20-%20Code%20Grocery%20-%20Start/models/grocery_item.dart';
import '../data/dummy_items.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) {
          final groceryItem = dummyGroceryItems[index];
          return GroceryListile(groceryItem: groceryItem);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => {
              // Navigate to add grocery item screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewItem()))
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryListile extends StatelessWidget {
  const GroceryListile({
    super.key,
    required this.groceryItem,
  });

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      title: Text(groceryItem.name),
      trailing: const Icon(Icons.delete),
    );
  }
}
