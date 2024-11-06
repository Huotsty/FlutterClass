import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Statefull widget - Button')),
        backgroundColor: Colors.deepPurple,
        body:  const Center(child:  Column(
          children: [
            SizedBox(height: 30),
            SelectableButton(),
            SizedBox(height: 10),
            SelectableButton(),
            SizedBox(height: 10),
            SelectableButton(),
            SizedBox(height: 10),
          ],
        )),
      ),
    ));

class SelectableButton extends StatefulWidget {
  const SelectableButton({super.key});

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  bool _isSelected = false;
  void toggleSelection() {
    setState(() {
      _isSelected =!_isSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(onPressed: toggleSelection, 
        style: ElevatedButton.styleFrom(
           backgroundColor: _isSelected ? Colors.blue : Colors.grey, // Change color
        ),
        child:  Center(
        child: Text(_isSelected ? 'SELECTED' : ' NOT SELECTED')
        ) 
        ),
      ),
      );
  }
}