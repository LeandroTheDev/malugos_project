import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class DrawerShop extends StatelessWidget {
  const DrawerShop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final option = Provider.of<Options>(context, listen: false);
    return Drawer(
      width: screenSize.width * 0.50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Main text
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.15,
              child: FittedBox(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: const [
                          Text(
                            'Carrinho',
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Icon(Icons.shopping_cart_outlined, size: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            //Products
            FittedBox(
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: option.cartItems.isEmpty
                          ? const Text(
                              'Carrinho Vazio :)',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              'Produtos',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                  SizedBox(width: screenSize.width * 0.1),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: option.cartItems.isEmpty
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {}, child: const Text('Limpar')))
                ],
              ),
            ),
            //Cart Items
            SizedBox(
              width: screenSize.width * 0.4,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: option.cartItems.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FittedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.16,
                                height: screenSize.height * 0.1,
                                child:
                                    Image.network(option.cartItems[i].imageURL),
                              ),
                              SizedBox(width: screenSize.width * 0.02),
                              Column(
                                children: [
                                  Text(option.cartItems[i].name),
                                  Text(option.cartItems[i].price.toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  option.cartItems.isEmpty
                      ? const SizedBox()
                      //Finish purchase
                      : ElevatedButton(
                          onPressed: () {},
                          child: const Text('Finalizar Compra')),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
