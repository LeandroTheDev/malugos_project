//On click show Feature Products
import 'package:flutter/material.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class FeatureProducts extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String imageURL;
  final String nameFull;

  const FeatureProducts({
    super.key,
    this.name = '',
    this.description = '',
    this.price = 0,
    this.imageURL = '',
    this.nameFull = '',
  });

  @override
  State<FeatureProducts> createState() => _FeatureProductsState();
}

class _FeatureProductsState extends State<FeatureProducts> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final optionW = Provider.of<Options>(context, listen: true);
    final option = Provider.of<Options>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Full name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.nameFull,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            //Image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: screenSize.height * 0.45,
                width: double.infinity,
                child: Image.network(widget.imageURL),
              ),
            ),
            //Description
            optionW.descMinimized
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          width: screenSize.width * 0.90,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(206, 171, 207, 171),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(widget.description),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                optionW.changeDescMinimaztion();
                              },
                              icon: const Icon(Icons.arrow_upward),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          width: screenSize.width * 0.90,
                          height: 120,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(206, 171, 207, 171),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(widget.description),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                optionW.changeDescMinimaztion();
                              },
                              icon: const Icon(Icons.arrow_downward),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            //"Adicionar ao carrinho"
            ElevatedButton(
                onPressed: () {
                  option.addCartItem(
                    Product(
                      name: widget.name,
                      description: widget.description,
                      price: widget.price,
                      imageURL: widget.imageURL,
                      nameFull: widget.nameFull,
                    ),
                  );
                },
                child: const Text('Adicionar ao Carrinho')),
            const SizedBox(height: 25),
            //"Ver no Site"
            ElevatedButton(onPressed: () {}, child: const Text('Ver no Site')),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
