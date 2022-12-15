import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProductItemSearch extends StatelessWidget {
  const ProductItemSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          const SizedBox(height: 7),
          //Product Image
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              width: 100,
              height: 100,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Image.network(
                  'imageUrl',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            width: 110,
            child: Column(children: [
              //Product Name
              AutoSizeText(
                'name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              //Product Cost
              AutoSizeText(
                '${2.toString()} Reais',
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
    );
  }
}
