import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter_1/1%20-Item%20Name%20Validation/models/grocery_category.dart';
import 'package:test_flutter_1/1%20-Item%20Name%20Validation/models/grocery_item.dart';
import 'package:test_flutter_1/1%20-Item%20Name%20Validation/widgets/grocery_list.dart';
import 'package:uuid/uuid.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.mode, this.item});
  final GroceryItem? item;
  final FormMode mode;

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();

  late GroceryCategory _selectedCategory;
  late String _enteredName;
  late int _enteredQuantity;
final uuid = const Uuid();
  @override
  initState() {
    super.initState();
    _selectedCategory = widget.item?.category ?? GroceryCategory.carbs;
    _enteredName = widget.item?.name ?? '';
    _enteredQuantity = widget.item?.quantity ?? 1;
  }

  void _saveItem() {
    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      // 2 - Save the form to get last entered values
      _formKey.currentState!.save();

      String newId = uuid.v4(); 
      GroceryItem newItem = GroceryItem(
          id: newId,
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory);

      Navigator.pop<GroceryItem>(context, newItem);
    }


    final updatedItem = GroceryItem(
    id: widget.item?.id ??  const Uuid().v4(), 
    name: _enteredName,
    quantity: _enteredQuantity,
    category: _selectedCategory,
  );

  Navigator.of(context).pop(updatedItem);
  }

  void _resetForm() {
    setState(() {
      _enteredName = '';
      _enteredQuantity = 1;
      _selectedCategory = GroceryCategory.carbs;
    });

    _formKey.currentState!.reset();
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

  // TODO: validate quantity
  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Please enter a valid, positive number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode.label),
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
                      initialValue: _enteredQuantity.toString(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: validateQuantity,
                      onSaved: (value) => _enteredQuantity = int.parse(value!),
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
                    onPressed: _saveItem,
                    child: Text(widget.mode.btnText),
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
