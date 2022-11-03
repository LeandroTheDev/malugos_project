import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  const ProductItem(this.name, this.price, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          //Product Image
          SizedBox(
            height: 160,
            width: 160,
            child: Image.network(imageUrl),
          ),
          //Product Name
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          //Product Cost
          Text(
            '${price.toString()} Reais',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
