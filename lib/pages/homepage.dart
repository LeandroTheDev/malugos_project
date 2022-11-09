import 'dart:async';

import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/productitem.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:malugos_project/pages/featurepage.dart';
import 'package:mysql1/mysql1.dart';
import '../data/mysqldata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Connect to the database and push Products Info
    Future pushProducts() async {
      //Estabilish connection
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      //Pick lenght of table products
      int lenght = await MySqlData.featureLenght();
      List<Product> data = [];
      for (var u = 1; u <= lenght; u++) {
        //Take the informations from database
        dynamic name =
            await mysql.query('select name from products where id = ?', [u]);
        name = name.toString().replaceFirst('(Fields: {name: ', '');
        name = name.substring(0, name.length - 2);
        dynamic price =
            await mysql.query('select price from products where id = ?', [u]);
        price = price.toString().replaceFirst('(Fields: {price: ', '');
        price = price.substring(0, price.length - 2);
        price = double.parse(price);
        dynamic imageURL = await mysql
            .query('select imageURL from products where id = ?', [u]);
        imageURL = imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
        imageURL = imageURL.substring(0, imageURL.length - 2);
        dynamic description = await mysql
            .query('select description from products where id = ?', [u]);
        description =
            description.toString().replaceFirst('(Fields: {description: ', '');
        description = description.substring(0, description.length - 2);
        dynamic nameFull = await mysql
            .query('select nameFULL from products where id = ?', [u]);
        nameFull = nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
        nameFull = nameFull.substring(0, nameFull.length - 2);
        //Repass the informations into variable
        Product productInfo = Product(
          id: u,
          name: name,
          description: description,
          price: price,
          imageURL: imageURL,
          nameFull: nameFull,
        );
        //Add informations into list
        data.add(productInfo);
      }
      return data;
    }

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
          //Features Horizontal View
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: screenSize.width,
              height: 210,
              child: FutureBuilder(
                future: pushProducts(),
                builder: (BuildContext context, future) {
                  if (future.data == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (BuildContext context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeatureProducts(
                                          name: future.data[i].name,
                                          description:
                                              future.data[i].description,
                                          price: future.data[i].price,
                                          imageURL: future.data[i].imageURL,
                                          nameFull: future.data[i].nameFull,
                                        )),
                              );
                            },
                            child: ProductItem(
                              future.data[i].name,
                              future.data[i].price,
                              future.data[i].imageURL,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
