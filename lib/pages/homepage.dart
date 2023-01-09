import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/productitem_list.dart';
import 'package:malugos_project/components/productitem_search.dart';
import 'package:malugos_project/components/productitem_show.dart';
import '../data/mysqldata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final searchText = TextEditingController();

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //Drawers
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: const AppDrawer(),
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.lightGreen,
        ),
        child: const DrawerShop(),
      ),
      //AppBar
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.shopping_bag_outlined),
            );
          }),
        ],
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
            //Search button
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Container(
                    width: screenSize.width * 0.73,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: screenSize.width * 0.75,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          width: screenSize.width * 0.75,
                          height: 50,
                          child: TextFormField(
                            controller: searchText,
                            style: const TextStyle(fontSize: 27),
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: screenSize.width * 0.20,
                            child: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductItemSearch(
                                        searchText.text.toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.shopping_cart,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Destaques',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Features Horizontal View
            FutureBuilder(
              future: MySqlData.pushProducts(id: 1, isHorizontal: true),
              builder: (BuildContext context, future) {
                if (future.data == null) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (context, i) {
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
                                            id: future.data[i].id,
                                            name: future.data[i].name,
                                            description:
                                                future.data[i].description,
                                            price: future.data[i].price,
                                            imageURL: future.data[i].imageURL,
                                            nameFull: future.data[i].nameFull,
                                            productLink:
                                                future.data[i].productURL,
                                          )),
                                );
                              },
                              child: ProductItemH(
                                future.data[i].name,
                                future.data[i].price,
                                future.data[i].imageURL,
                                screenSize.width,
                                screenSize.height * 0.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            //"Mais Vendidos"
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mostsellpage');
              },
              child: Container(
                width: screenSize.width * 0.45,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.shop,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mais Vendidos',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Images
            FutureBuilder(
                future: MySqlData.pushImages(),
                builder: (context, future) {
                  if (future.data == null) {
                    return const CircularProgressIndicator();
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
                Navigator.pushNamed(context, '/promopage');
              },
              child: Container(
                width: screenSize.width * 0.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.sell_outlined,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Promoção',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Promotions Horizontal View
            FutureBuilder(
              future: MySqlData.pushProducts(
                id: 1,
                isPromo: true,
                isHorizontal: true,
                isMostSell: false,
              ),
              builder: (BuildContext context, future) {
                if (future.data == null) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (context, i) {
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
                                            id: future.data[i].id,
                                            name: future.data[i].name,
                                            description:
                                                future.data[i].description,
                                            price: future.data[i].price,
                                            imageURL: future.data[i].imageURL,
                                            nameFull: future.data[i].nameFull,
                                            productLink:
                                                future.data[i].productURL,
                                          )),
                                );
                              },
                              child: ProductItemH(
                                future.data[i].name,
                                future.data[i].price,
                                future.data[i].imageURL,
                                screenSize.width,
                                screenSize.height * 0.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
