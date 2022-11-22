import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Keyboard
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                ),
                onPressed: () {},
                child: SizedBox(
                  width: screenSize.width,
                  height: 100,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(52, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.keyboard_outlined,
                              size: 50,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Teclados',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Mouses
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                ),
                onPressed: () {},
                child: SizedBox(
                  width: screenSize.width,
                  height: 100,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(52, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.mouse_outlined,
                              size: 50,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Mouses',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Monitors
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                ),
                onPressed: () {},
                child: SizedBox(
                  width: screenSize.width,
                  height: 100,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(52, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.monitor,
                              size: 50,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Monitores',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
