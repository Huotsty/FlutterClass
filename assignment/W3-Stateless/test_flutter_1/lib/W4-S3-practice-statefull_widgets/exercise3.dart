import 'package:flutter/material.dart';

List<String> images = [
  "assets/w4-s2/bird.jpg",
  "assets/w4-s2/bird2.jpg",
  "assets/w4-s2/insect.jpg",
  "assets/w4-s2/girl.jpg",
  "assets/w4-s2/man.jpg",
];

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Why this line ? Can you explain it ? the debug check mode banner dissapear
      home: ImageViewer(),
    ));

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int _index = 0;
 
  void _incrementIndex() {
    setState(() {
      // _index = (_index + 1) % images.length;
      _index = (_index - 1 + images.length) % images.length;
    });
  }

  void _decrementIndex() {
    setState(() {
      // _index = (_index - 1 + images.length) % images.length;
      _index = (_index + 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: _incrementIndex,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next image',
              onPressed: _decrementIndex,
            ),
          ),
        ],
      ),
      body: Image.asset(images[_index]),
    );
  }
}
