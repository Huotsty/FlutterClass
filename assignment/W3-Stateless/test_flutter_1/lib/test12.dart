import 'package:flutter/material.dart';

void main() {
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> numbers = ["MON", "TUE", "WED", "THU"];
    List<Widget> getLabels() {
      return numbers.map((item) => Text(item)).toList();
    }

    return MaterialApp(
      home: Column(
        children: [
          const Text("Start"),
          // for (var i = 0; i < 10; i++) Text('Item $i'),
          // ...numbers.map((item) => Text(item)).toList(),
          ...getLabels(),
          const Text("End"),
        ],
      ),
    );
  }
}
