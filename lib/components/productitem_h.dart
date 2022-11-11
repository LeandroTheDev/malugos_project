import 'package:flutter/material.dart';

class ProductItemH extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  const ProductItemH(this.name, this.price, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          const SizedBox(height: 7),
          //Product Image
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            height: 160,
            width: 160,
            child: Image.network(
              imageUrl,
              scale: 8,
            ),
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
