//On click show Feature Products
import 'package:flutter/material.dart';

class FeatureProducts extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
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
                  nameFull,
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
                child: Image.network(imageURL),
              ),
            ),
            //Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: screenSize.width * 0.90,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(206, 171, 207, 171),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(description),
              ),
            ),
            //"Adicionar ao carrinho"
            ElevatedButton(
                onPressed: () {}, child: const Text('Adicionar ao Carrinho')),
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