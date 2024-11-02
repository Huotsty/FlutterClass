import 'package:flutter/material.dart';

enum ProductType {
  dart,
  flutter,
  firebase,
}

class Product {
  final ProductType type;
  final String imagePath;
  final String description;

  const Product({
    required this.type,
    required this.imagePath,
    required this.description,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const products = [
      Product(
        type: ProductType.dart,
        imagePath: 'assets/dart.png',
        description: 'the best object programming language',
      ),
      Product(
        type: ProductType.flutter,
        imagePath: 'assets/flutter.png',
        description: 'Flutter is a multi-platform ',
      ),
      Product(
        type: ProductType.firebase,
        imagePath: 'assets/firebase.png',
        description: 'database',
      )
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: products
                  .map((product) => ProductCard(product: product))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(product.imagePath),
            const SizedBox(width: 20.0),
            Text(
              product.type.toString().split('.').last,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20.0),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}
