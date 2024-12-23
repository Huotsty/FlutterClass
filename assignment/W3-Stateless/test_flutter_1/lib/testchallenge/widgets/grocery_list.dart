import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

enum HomeMode {
  normal,
  selection;
}

enum FormMode {
  edit("Edit item", "Edit"),
  create("Add a new item", "Add");

  final String formAppBarTitle;
  final String formBtnTitle;
  const FormMode(this.formAppBarTitle, this.formBtnTitle);
}

class GroceryList extends StatefulWidget {
  const GroceryList({super.key, required this.groceryItems});

  final List<GroceryItem> groceryItems;

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late List<GroceryItem> currentGroceryItems;

  Set<int> selectedItems = {};

  HomeMode mode = HomeMode.normal;

  @override
  void initState() {
    super.initState();
    currentGroceryItems = widget.groceryItems;
  }

  void switchScreen() {
    setState(() {
      mode = mode == HomeMode.normal ? HomeMode.selection : HomeMode.normal;
      if (mode == HomeMode.normal) {
        selectedItems.clear(); 
      }
    });
  }

  void checkSelection(bool? value, int index) {
    setState(() {
      if (value == true) {
        selectedItems.add(index);
      } else {
        selectedItems.remove(index); 
      }
    });
  }

  void removeItem() {
    setState(() {
      currentGroceryItems.removeWhere(
          (item) => selectedItems.contains(currentGroceryItems.indexOf(item)));
      selectedItems.clear();
      mode = HomeMode.normal;
    });
  }

  Future<void> _addItem({GroceryItem? item, required FormMode mode}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          inputGrocery: item,
          screenMode: mode,
        ),
      ),
    );
    if (context.mounted && result != null) return;

    setState(() {
      if (mode == FormMode.edit) {
        final index = currentGroceryItems.indexWhere((i) => i.id == item!.id);
        if (index != -1) {
          currentGroceryItems[index] = result;
        }
      } else if (mode == FormMode.create) {
        currentGroceryItems.add(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));
    if (currentGroceryItems.isNotEmpty) {
      content = ReorderableListView.builder(
        itemCount: currentGroceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(
          key: ValueKey(currentGroceryItems[index].id),
          changedFunction: (value) => checkSelection(value, index),
          index: index,
          longPressFunction: switchScreen,
          mode: mode,
          groceryItem: currentGroceryItems[index],
          tapFunction: (_) => _addItem(
            mode: FormMode.edit,
            item: currentGroceryItems[index],
          ),
        ),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final GroceryItem item = currentGroceryItems.removeAt(oldIndex);
            currentGroceryItems.insert(newIndex, item);
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: mode == HomeMode.normal
            ? const Text('Your Groceries')
            : const Text('Selected Item(s)'),
        actions: mode == HomeMode.normal
            ? [
                IconButton(
                  onPressed: () => _addItem(mode: FormMode.create),
                  icon: const Icon(Icons.add),
                ),
              ]
            : [ 
                IconButton(
                  onPressed: removeItem,
                  icon: const Icon(Icons.delete),
                ),
              ],
        leading: mode == HomeMode.selection
            ? IconButton(
                onPressed: switchScreen,
                icon: const Icon(Icons.arrow_back),
              )
            : null,
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({
    super.key,
    required this.tapFunction,
    required this.groceryItem,
    required this.mode,
    required this.longPressFunction,
    required this.index,
    required this.changedFunction,
  });

  final GroceryItem groceryItem;
  final Function(FormMode) tapFunction;
  final HomeMode mode;
  final VoidCallback longPressFunction;
  final int index;
  final Function(bool?) changedFunction;

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case HomeMode.normal:
        return ListTile(
          onTap: () => tapFunction(FormMode.edit),
          onLongPress: longPressFunction,
          title: Text(groceryItem.name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItem.category.color,
          ),
          trailing: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: Text(
              groceryItem.quantity.toString(),
            ),
          ),
        );
      case HomeMode.selection:
        return ListTile(
          title: Text(groceryItem.name),
          leading: Checkbox(
            value: context
                .findAncestorStateOfType<_GroceryListState>()!
                .selectedItems
                .contains(index),
            onChanged: (value) => changedFunction(value),
          ),
          trailing: Text(
            groceryItem.quantity.toString(),
          ),
        );
    }
  }
}
