import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FittedBox(
        child: SizedBox(
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
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
        ),
      ),
    );
  }
}

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
