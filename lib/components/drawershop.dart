import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class DrawerShop extends StatelessWidget {
  const DrawerShop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final option = Provider.of<Options>(context, listen: false);
    final optionW = Provider.of<Options>(context, listen: true);
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
                  //Cleanup Cart
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: option.cartItems.isEmpty
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Limpar Carrinho'),
                                      content: const Text('Tem certeza?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            optionW.removeAllCartItem();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Sim'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Não'),
                                        ),
                                      ],
                                    );
                                  }),
                              child: const Text('Limpar')))
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
                              Container(
                                width: screenSize.width * 0.16,
                                height: screenSize.height * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                padding: const EdgeInsets.all(3),
                                child:
                                    Image.network(option.cartItems[i].imageURL),
                              ),
                              //Name and Price
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 90,
                                      child: Text(
                                        option.cartItems[i].name,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Delete
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Remover Produto'),
                                            content: const Text('Tem certeza?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  optionW
                                                      .removeSpecificCartItem(
                                                          i);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Sim'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Não'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: screenSize.width * 0.08,
                                    height: screenSize.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red,
                                    ),
                                    child: const Icon(Icons.delete),
                                  ),
                                ),
                              ),
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/finishpurchase');
                          },
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
