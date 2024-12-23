import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';


enum SelectMode { normal, selection }

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  SelectMode currentMode = SelectMode.normal;
  final Set<GroceryItem> selectedItems = {};

  void _addItem() async {
    final GroceryItem? newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(
          mode: OperationMode.Creating,
        ),
      ),
    );
    if (newItem != null) {
      setState(() {
        dummyGroceryItems.add(newItem);
      });
    }
  }

  void _editItem(GroceryItem item) async {
    final GroceryItem? updatedItem =
        await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          mode: OperationMode.Editing,
          item: item,
        ),
      ),
    );

    if (updatedItem != null) {
      setState(() {
        final index = dummyGroceryItems.indexOf(item);
        if (index >= 0) {
          dummyGroceryItems[index] = updatedItem;
        }
      });
    }
  }

  void reOrderItem(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final item = dummyGroceryItems.removeAt(oldIndex);

      dummyGroceryItems.insert(newIndex, item);
    });
  }

  void _toggleSelectionMode() {
    setState(() {
      if (currentMode == SelectMode.normal) {
        currentMode = SelectMode.selection;
      } else {
        currentMode = SelectMode.normal;
        selectedItems.clear();
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      dummyGroceryItems.removeWhere((item) => selectedItems.contains(item));
      selectedItems.clear();
      currentMode = SelectMode.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ReorderableListView.builder(
        itemBuilder: (ctx, index) => GroceryTile(
          groceryItem: dummyGroceryItems[index],
          mode: currentMode,
          key: ValueKey(dummyGroceryItems[index]),
          onTap: () {
            if (currentMode == SelectMode.normal) {
              _editItem(dummyGroceryItems[index]);
            } else {
              setState(() {
                if (selectedItems.contains(dummyGroceryItems[index])) {
                  selectedItems.remove(dummyGroceryItems[index]);
                } else {
                  selectedItems.add(dummyGroceryItems[index]);
                }
              });
            }
          },
          isSelected: selectedItems.contains(dummyGroceryItems[index]),
        ),
        itemCount: dummyGroceryItems.length,
        onReorder: reOrderItem,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentMode == SelectMode.selection
            ? '${selectedItems.length} selected'
            : 'Your Groceries'),
        actions: currentMode == SelectMode.selection
            ? [
                IconButton(
                  onPressed: _removeSelectedItems,
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [
                IconButton(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                ),
              ],
        leading: currentMode == SelectMode.selection
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleSelectionMode,
              )
            : null,
      ),
      body: GestureDetector(
        onLongPress: _toggleSelectionMode,
        child: content,
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({
    super.key,
    required this.groceryItem,
    required this.onTap,
    required this.mode,
    required this.isSelected,
  });

  final GroceryItem groceryItem;
  final VoidCallback onTap;
  final SelectMode mode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(groceryItem.name),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (mode == SelectMode.selection)
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
              ),
            Container(
              width: 24,
              height: 24,
              color: groceryItem.category.color,
            ),
          ],
        ),
        trailing: Text(
          groceryItem.quantity.toString(),
        ),
      ),
    );
  }
}
