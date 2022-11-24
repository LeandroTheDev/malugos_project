import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class KeybordCategory extends StatelessWidget {
  const KeybordCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List<String> data = [];
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
                        onPressed: () {},
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
                              .changeSort('preco');
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
                  //Nome
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
          FutureBuilder(
            future: MySqlData.pushCategoryItem(
              data,
              Provider.of<Options>(context, listen: false).sort,
              'teclados',
            ),
            builder: ((context, future) {
              if (future.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: future.data?.length,
                    itemBuilder: ((context, index) {
                      return const Text(
                        'data',
                        style: TextStyle(color: Colors.white),
                      );
                    }),
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
