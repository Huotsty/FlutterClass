import 'package:flutter/material.dart';

import '../models/course.dart';

class AddStudentForm extends StatefulWidget {
  const AddStudentForm({super.key, required this.inputedStudent});
  final StudentScore inputedStudent;
  @override
  State<AddStudentForm> createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  String _enteredName = '';

  double _enteredScore = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('add student'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                TextFormField(
                  controller: _studentController,
                  decoration: const InputDecoration(labelText: "name"),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 50) {
                      return "name must be between 50 and 0 characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                TextFormField(
                  controller: _scoreController,
                  decoration: const InputDecoration(labelText: "score"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an score";
                    }
                    if (double.tryParse(value) == null ||
                        double.tryParse(value)! > 100) {
                      return "Please enter a valid number score cannot be greater than 100";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredScore = value as double;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(
                        context,
                        StudentScore(name: _enteredName, score: _enteredScore,),
                      );
                    }
                  },
                  child: const Text("Add Item"),
                ),
              ],
            ),
          ),
        ));
  }
}
