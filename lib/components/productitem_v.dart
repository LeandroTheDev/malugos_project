import 'package:flutter/material.dart';

class ProductItemV extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  const ProductItemV(this.name, this.price, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.3,
      height: screenSize.height * 0.25,
      child: Column(
        children: [
          const SizedBox(height: 7),
          //Product Image
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            width: screenSize.width,
            height: screenSize.height * 0.16,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Image.network(
                imageUrl,
              ),
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
          Expanded(
            child: Text(
              '${price.toString()} Reais',
              style: const TextStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
