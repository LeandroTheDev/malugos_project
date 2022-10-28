import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;

  ProductItem(this.name, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Column(
        children: [
          Text(name),
          Text('${price.toString()} Reais'),
        ],
      ),
    );
  }
}
