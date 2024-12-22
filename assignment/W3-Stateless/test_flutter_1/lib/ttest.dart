// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: UnboundedHeightExample()));
// }

// class UnboundedHeightExample extends StatelessWidget {
//   const UnboundedHeightExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Unbounded Height Example")),
//       body: Column(
//         children: [
//           const Text("Fixed Widget"),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 50,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text("Item $index"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: FixedHeightExample()));
// }

// class FixedHeightExample extends StatelessWidget {
//   const FixedHeightExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Fixed Height Example")),
//       body: Column(
//         children: [
//           const Text("Fixed Widget"),
//           SizedBox(
//             height: 200, // Fixed height
//             child: ListView.builder(
//               itemCount: 50,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text("Item $index"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: ShrinkWrapExample()));
// }

// class ShrinkWrapExample extends StatelessWidget {
//   const ShrinkWrapExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("ShrinkWrap Example")),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text("Scrollable Content"),
//             ListView.builder(
//               shrinkWrap: true, // Makes the ListView size itself to its content
//               physics:
//                   const NeverScrollableScrollPhysics(), // Prevents internal scrolling
//               itemCount: 10,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text("Item $index"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ScrollableExample()));
}

class ScrollableExample extends StatelessWidget {
  const ScrollableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scrollable Example")),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            50,
            (index) => ListTile(title: Text("Item $index")),
          ),
        ),
      ),
    );
  }
}
