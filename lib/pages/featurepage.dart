import 'package:flutter/material.dart';

//Feature Page
class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destaques'),
      ),
      body: Column(),
    );
  }
}

//Horizontal Featured Itens Page
class FeatureProducts extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String imageURL;

  const FeatureProducts(
      {super.key,
      this.name = '',
      this.description = '',
      this.price = 0,
      this.imageURL = ''});

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
                height: 400,
                width: screenSize.width * 0.90,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(206, 171, 207, 171),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(description),
              ),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('Adicionar ao Carrinho')),
            const SizedBox(height: 25),
            ElevatedButton(onPressed: () {}, child: const Text('Ver no Site')),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
