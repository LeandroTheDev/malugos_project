import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/productitem.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:malugos_project/pages/featurepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          const SizedBox(height: 30),
          //"Destaques"
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/featurepage');
            },
            child: Container(
              width: screenSize.width * 0.4,
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
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          //"Destaque" Products
          SizedBox(
            width: screenSize.width,
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyproducts.length,
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeatureProducts(
                                name: dummyproducts[i].name,
                                description: dummyproducts[i].description,
                                price: dummyproducts[i].price,
                                imageURL: dummyproducts[i].imageURL,
                              )),
                    );
                  },
                  child: ProductItem(
                    dummyproducts[i].name,
                    dummyproducts[i].price,
                    dummyproducts[i].imageURL,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
