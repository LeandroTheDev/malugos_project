import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  ProductItem(this.name, this.price, this.imageUrl, {super.key});

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
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          //Product Cost
          Text('${price.toString()} Reais'),
        ],
      ),
    );
  }
}
