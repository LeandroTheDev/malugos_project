import 'package:flutter/material.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:malugos_project/components/productitem_v.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class KeybordCategory extends StatelessWidget {
  const KeybordCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teclados'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              //Sort
              child: Row(
                children: [
                  SizedBox(width: screenSize.width * 0.05),
                  //Sort By
                  Container(
                    width: screenSize.width * 0.3,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 177, 255, 87),
                    ),
                    child: FittedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(0, 0, 0, 0))),
                        onPressed: () {
                          Provider.of<Options>(context, listen: false)
                              .changeSort('');
                          //SetState
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: ((context) => this)),
                          );
                        },
                        child: const Text(
                          'Ordenar por',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                  //Price
                  Container(
                    width: screenSize.width * 0.2,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightGreen,
                    ),
                    child: FittedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(0, 0, 0, 0))),
                        onPressed: () {
                          Provider.of<Options>(context, listen: false)
                              .changeSort('price');
                          //SetState
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: ((context) => this)),
                          );
                        },
                        child: const Text(
                          'Preço',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.03),
                  //New
                  Container(
                    width: screenSize.width * 0.2,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightGreen,
                    ),
                    child: FittedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(0, 0, 0, 0))),
                        onPressed: () {
                          Provider.of<Options>(context, listen: false)
                              .changeSort('new');
                          //SetState
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: ((context) => this)),
                          );
                        },
                        child: const Text(
                          'Novo',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.03),
                  //Name
                  Container(
                    width: screenSize.width * 0.2,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightGreen,
                    ),
                    child: FittedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(0, 0, 0, 0))),
                        onPressed: () {
                          Provider.of<Options>(context, listen: false)
                              .changeSort('name');
                          //SetState
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: ((context) => this)),
                          );
                        },
                        child: const Text(
                          'Nome',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Products
          FutureBuilder(
            future: MySqlData.pushCategoryItem(
                id: 1,
                category: 'Teclado',
                order: Provider.of<Options>(context).sort),
            builder: ((context, future) {
              if (future.hasData) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: future.data!.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeatureProducts(
                                          name: future.data![index].name,
                                          description:
                                              future.data![index].description,
                                          price: future.data![index].price,
                                          imageURL:
                                              future.data![index].imageURL,
                                          nameFull:
                                              future.data![index].nameFull,
                                        )),
                              );
                            },
                            child: ProductItemV(
                              future.data![index].name,
                              future.data![index].price,
                              future.data![index].imageURL,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ],
      ),
    );
  }
}
