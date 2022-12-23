import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:provider/provider.dart';

import '../../data/provider.dart';

class FinishPurchase extends StatelessWidget {
  const FinishPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final option = Provider.of<Options>(context, listen: true);
    double returnTotalPrice() {
      double totalPrice = 0;
      for (int i = 0; i <= option.cartItems.length - 1; i++) {
        totalPrice = totalPrice + option.cartItems[i].price;
      }
      totalPrice = double.parse(totalPrice.toStringAsFixed(2));
      return totalPrice;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Finalizar Compra'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Products
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: screenSize.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightGreen,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FittedBox(
                      child: Text(
                        'Total: ${returnTotalPrice()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 100),
                      ),
                    ),
                  ),
                ),
              ),
              //Item Product
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: option.cartItems.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Row(
                          children: [
                            //Product
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeatureProducts(
                                      id: option.cartItems[i].id,
                                      name: option.cartItems[i].name,
                                      description:
                                          option.cartItems[i].description,
                                      price: option.cartItems[i].price,
                                      imageURL: option.cartItems[i].imageURL,
                                      nameFull: option.cartItems[i].nameFull,
                                      productLink:
                                          option.cartItems[i].productURL,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 240,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightGreen,
                                ),
                                child: FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            child: AutoSizeText(
                                              minFontSize: 1,
                                              maxFontSize: 100,
                                              option.cartItems[i].name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: AutoSizeText(
                                              minFontSize: 1,
                                              maxFontSize: 100,
                                              option.cartItems[i].price
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white),
                                        width: 40,
                                        height: 40,
                                        padding: const EdgeInsets.all(3),
                                        child: Image.network(
                                            option.cartItems[i].imageURL),
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            //Remove
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Remover Produto'),
                                          content: const Text('Tem certeza?'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                option
                                                    .removeSpecificCartItem(i);
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
                                  width: 30,
                                  height: 60,
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
                  }),
              const SizedBox(height: 10),
              //Finish Purchase button
              SizedBox(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.1,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/paymentpage');
                  },
                  child: const AutoSizeText(
                    minFontSize: 5,
                    maxFontSize: 30,
                    'Escolher Pagamento',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metodo de compra'),
      ),
      body: Center(
        child: Container(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Cartão'),
                  CardFormField(
                    controller: CardFormEditController(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
