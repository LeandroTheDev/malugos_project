import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/productitem.dart';
import 'package:malugos_project/data/productsdata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          child: SizedBox(
            height: 65,
            child: Image.asset("assets/malugosicon.png"),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          //"Destaques"
          Container(
            width: screenSize.width * 0.3,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Row(
              children: const [
                Spacer(),
                Icon(
                  Icons.shopping_cart,
                  color: Colors.lightGreen,
                ),
                SizedBox(width: 5),
                Text(
                  'Destaques',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //"Destaque" Products
          SizedBox(
            width: screenSize.width,
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyproducts.length,
              itemBuilder: (context, i) {
                return ProductItem(
                  dummyproducts[i].name,
                  dummyproducts[i].price,
                  dummyproducts[i].imageURL,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
