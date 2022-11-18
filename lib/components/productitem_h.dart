import 'package:flutter/material.dart';

class ProductItemH extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final double screenSizeWidth;
  final double screenSizeHeigth;

  const ProductItemH(this.name, this.price, this.imageUrl, this.screenSizeWidth,
      this.screenSizeHeigth,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSizeWidth * 0.4,
      child: Column(children: [
        SizedBox(height: screenSizeHeigth * 0.03),
        //Image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            alignment: Alignment.center,
            height: screenSizeHeigth * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: SizedBox(
                height: screenSizeHeigth * 0.65,
                child: Image.network(
                  imageUrl,
                )),
          ),
        ),
        SizedBox(height: screenSizeHeigth * 0.03),
        //Text
        SizedBox(
          height: screenSizeHeigth * 0.24,
          width: double.infinity,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'R\$ $price',
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
