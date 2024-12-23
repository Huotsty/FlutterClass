import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

enum OperationMode {
  Editing,
  Creating,
}

class NewItem extends StatefulWidget {
  final OperationMode mode;
  const NewItem({super.key, required this.mode, this.item});
  final GroceryItem? item;

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();
  late String _enteredName;
  late GroceryCategory _selectedCategory;
  late int _enterVal;

  @override
  void initState() {
    super.initState();

    if (widget.mode == OperationMode.Editing) {
      _enteredName = widget.item!.name;
      _enterVal = widget.item!.quantity;
      _selectedCategory = widget.item!.category;
    } else {
      _enteredName = '';
      _enterVal = 0;
      _selectedCategory = GroceryCategory.fruit;
    }
  }

  void _saveItem() {
    var uuid = Uuid();
    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      GroceryItem newItem = GroceryItem(
        id: uuid.v4(),
        name: _enteredName,
        quantity: _enterVal,
        category: _selectedCategory,
      );

      Navigator.pop(context, newItem);
      print(
          "Name $_enteredName Quantity $_enterVal Category $_selectedCategory}");
    }
  }

  void _editItem() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      GroceryItem newItem = GroceryItem(
        id: widget.item!.id,
        name: _enteredName,
        quantity: _enterVal,
        category: _selectedCategory,
      );

      Navigator.pop(context, newItem);
      print(
          "Name $_enteredName Quantity $_enterVal Category $_selectedCategory}");
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _enteredName = '';
      _selectedCategory = GroceryCategory.fruit;
      _enterVal = 0;
    });
  }

  String? validateTitle(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    _enterVal = int.tryParse(value!) ?? 0;
    if (_enterVal <= 0) {
      return 'Must be a valid, positive number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == OperationMode.Creating
            ? 'Add a new item'
            : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      validator: validateQuantity,
                      initialValue: _enterVal.toString(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: _selectedCategory,
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCategory = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: widget.mode == OperationMode.Creating
                        ? _saveItem
                        : _editItem,
                    child: Text(widget.mode == OperationMode.Creating
                        ? 'Add Item'
                        : 'Edit Item'),
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
