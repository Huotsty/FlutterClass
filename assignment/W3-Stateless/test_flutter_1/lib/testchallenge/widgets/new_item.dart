import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter_1/testchallenge/widgets/grocery_list.dart';

import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.screenMode, this.inputGrocery});

  final FormMode screenMode;
  final GroceryItem? inputGrocery;

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';

  int _enteredQuantity = 0;

  late GroceryCategory _enteredGroceryCategory;

  GroceryItem? currentGroceryItem;

  bool get validateNullGrocery => currentGroceryItem != null;

  @override
  void initState() {
    super.initState();
    currentGroceryItem = widget.inputGrocery;
  }

  void _saveItem() {

    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      
      // 2 - Save the form to get last entered values
      _formKey.currentState!.save();
      Navigator.pop(context, GroceryItem(id: 'd', name: _enteredName, quantity: _enteredQuantity, category: _enteredGroceryCategory));
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
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
    if (value == null || value.isEmpty) {
      return "Must be valid"; 
    }
    
    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      return "Must be a valid number";
    }

    if (parsedValue < 0) {
      return "Must be a positive number"; 
    }

    return null; // Input is valid.
  }

  String? validateCategory(GroceryCategory? value) {
    if (value == null ) {
      return "Must be valid category";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenMode.formAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                initialValue: validateNullGrocery ? currentGroceryItem!.name : "",
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: validateNullGrocery ? currentGroceryItem!.quantity.toString() : '1',
                      validator: validateQuantity,
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: validateNullGrocery ? currentGroceryItem!.category : null,
                      validator: validateCategory,
                      onSaved: (value) => _enteredGroceryCategory = value!,
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
                      onChanged: (value) {},
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
                    onPressed: _saveItem,
                    child: Text(widget.screenMode.formBtnTitle),
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
