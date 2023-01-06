import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProductItemV extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  const ProductItemV(this.name, this.price, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FittedBox(
        child: Column(
          children: [
            const SizedBox(height: 7),
            //Product Image
            FittedBox(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                width: 120,
                height: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Image.network(
                    imageUrl,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 38,
              width: 110,
              child: Column(children: [
                //Product Name
                AutoSizeText(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                //Product Cost
                AutoSizeText(
                  '${price.toString()} Reais',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
