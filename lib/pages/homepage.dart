import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/productitem_h.dart';
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
    Future pushProducts([id]) async {
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
      int lenght = await MySqlData.featureLenght(id);
      List<Product> data = [];
      for (id; id <= lenght; id++) {
        //Take the informations from database
        dynamic name =
            await mysql.query('select name from products where id = ?', [id]);
        name = name.toString().replaceFirst('(Fields: {name: ', '');
        name = name.substring(0, name.length - 2);
        dynamic price =
            await mysql.query('select price from products where id = ?', [id]);
        price = price.toString().replaceFirst('(Fields: {price: ', '');
        price = price.substring(0, price.length - 2);
        price = double.parse(price);
        dynamic imageURL = await mysql
            .query('select imageURL from products where id = ?', [id]);
        imageURL = imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
        imageURL = imageURL.substring(0, imageURL.length - 2);
        dynamic description = await mysql
            .query('select description from products where id = ?', [id]);
        description =
            description.toString().replaceFirst('(Fields: {description: ', '');
        description = description.substring(0, description.length - 2);
        dynamic nameFull = await mysql
            .query('select nameFULL from products where id = ?', [id]);
        nameFull = nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
        nameFull = nameFull.substring(0, nameFull.length - 2);
        //Repass the informations into variable
        Product productInfo = Product(
          id: id,
          name: name,
          description: description,
          price: price,
          imageURL: imageURL,
          nameFull: nameFull,
        );
        //Add informations into list
        data.add(productInfo);
      }
      await mysql.close();
      return data;
    }

    //Connect to the database and push Images url
    Future pushImages() async {
      //Debug
      List<String> imageURL = [
        'https://www.malugos.com.br/templates/g5_helium/custom/images/banners/banner%20m%C3%A9dio%20PC%20GAMER.jpg',
        'https://www.malugos.com.br/templates/g5_helium/custom/images/banners/MINI%20BANNER%20PC%20CORPORATIVO.jpg',
        'https://www.malugos.com.br/templates/g5_helium/custom/images/banners/Banner%20headset.png',
      ];
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
      return imageURL;
    }

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const AppDrawer(),
      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          child: SizedBox(
            height: 65,
            child: Image.asset("assets/malugosicon.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(
              width: screenSize.width,
              height: 210,
              child: FutureBuilder(
                future: pushProducts(1),
                builder: (BuildContext context, future) {
                  if (future.data == null) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (BuildContext context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(30)),
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
                              child: ProductItemH(
                                future.data[i].name,
                                future.data[i].price,
                                future.data[i].imageURL,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            //"Mais Vendidos"
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/featurepage');
              },
              child: Container(
                width: screenSize.width * 0.45,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Icon(
                      Icons.shop,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Mais Vendidos',
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
            //Images
            FutureBuilder(
                future: pushImages(),
                builder: (context, future) {
                  if (future.data == null) {
                    return const SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator());
                  } else {
                    return TextButton(
                      onPressed: () {},
                      child: SizedBox(
                        width: screenSize.width,
                        height: 200,
                        child: CarouselSlider.builder(
                          itemCount: future.data.length,
                          options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3)),
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              color: Colors.lightGreen,
                              child: Image.network(future.data[index]),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            //"Promoção"
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
                      Icons.sell_outlined,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Promoção',
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
            //Promotions Horizontal View
            FutureBuilder(builder: (context, future) {
              if (future.data == null) {
                return const SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                    return Container();
                  }),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
