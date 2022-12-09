import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryShow extends StatefulWidget {
  Map order;
  HistoryShow(this.order, {super.key});

  @override
  State<HistoryShow> createState() => _HistoryShowState();
}

class _HistoryShowState extends State<HistoryShow> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Products
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: screenSize.width * 0.6,
                height: screenSize.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightGreen),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.web_rounded, size: 10),
                        SizedBox(width: 2),
                        Text(
                          'Produtos',
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Products Show
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.order.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Container(
                      height: screenSize.height * 0.3,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightGreen),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.25,
                                    height: 40,
                                    child: AutoSizeText(
                                      minFontSize: 7,
                                      maxFontSize: 20,
                                      'Nome: ${widget.order['Product$i']['nameFULL']}',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.25,
                                    child: Text(
                                      'Preço: ${widget.order['Product$i']['price']}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.network(
                                        widget.order['Product$i']['imageURL'])),
                              ),
                            )
                          ],
                        ),
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
