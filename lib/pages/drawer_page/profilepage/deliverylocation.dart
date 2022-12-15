import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';
import '../../../data/mysqldata.dart';
import '../../../data/provider.dart';

class DeliveryLocation extends StatefulWidget {
  const DeliveryLocation({super.key});

  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends State<DeliveryLocation> {
  @override
  Widget build(BuildContext context) {
    final option = Provider.of<Options>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;

    //Push items in delivery mysql
    Future<Map<String, dynamic>> pushDelivery() async {
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      dynamic results = await mysql
          .query('select delivery from userdata where id = ?', [option.id]);
      results = results.toString().replaceFirst('(Fields: {delivery: ', '');
      results = results.substring(0, results.length - 2);
      Map<String, dynamic> data = jsonDecode(results);
      await mysql.close();
      return data;
    }

    //Remove specific delivery location
    Future removeDelivery(int deliveryNumber) async {
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      dynamic results = await mysql
          .query('select delivery from userdata where id = ?', [option.id]);
      results = results.toString().replaceFirst('(Fields: {delivery: ', '');
      results = results.substring(0, results.length - 2);
      Map<String, dynamic> data = jsonDecode(results);
      Map<String, dynamic> returned = {};
      data.remove('Delivery$deliveryNumber');
      int a = 0;
      //Add all the passed informations to the new informations
      while (true) {
        if (data['Delivery$a'] == null) {
          break;
        }
        returned['Delivery$a'] = data['Delivery$a'];
        a++;
      }
      //Change the numbers after the remove to be compatible to the listview
      for (int i = deliveryNumber; i <= data.length - deliveryNumber; i++) {
        if (data['Delivery${i + 1}'] == null) {
          break;
        }
        returned['Delivery$i'] = data['Delivery${i + 1}'];
      }
      results = jsonEncode(returned);
      //Send to the database
      await mysql.query(
          'update userdata set delivery=? where id=?', [results, option.id]);
      await mysql.close();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }

    Future addNewLocation(Map<String, dynamic> value) async {
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      dynamic results = await mysql
          .query('select delivery from userdata where id = ?', [option.id]);
      results = results.toString().replaceFirst('(Fields: {delivery: ', '');
      results = results.substring(0, results.length - 2);
      results = jsonDecode(results);
      results['Delivery${results.length}'] = value;
      results = jsonEncode(results);
      await mysql.query(
          'update userdata set delivery=? where id=?', [results, option.id]);
      await mysql.close();
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locais de Entrega'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Add delivery button
              FittedBox(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: screenSize.height * 0.65,
                          color: Colors.lightGreen,
                          child: SingleChildScrollView(
                            child: FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Add
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Adicionar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Road name
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Nome da Rua'),
                                      ),
                                      const SizedBox(height: 10),
                                      // Road name Form
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Container(
                                                width: 270,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 170, 221, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 270,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextFormField(
                                                  controller: option.roadName,
                                                  keyboardType: TextInputType
                                                      .streetAddress,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Number and State name
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          children: const [
                                            Text('Número'),
                                            SizedBox(width: 140),
                                            Text('Estado'),
                                            SizedBox(width: 25),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Number and State form
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            //Road Number
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7.0),
                                                  child: Container(
                                                    width: 75,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 170, 221, 112),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 75,
                                                  height: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: TextFormField(
                                                      controller:
                                                          option.roadNumber,
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 120),
                                            //State
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7.0),
                                                  child: Container(
                                                    width: 75,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 170, 221, 112),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 75,
                                                  height: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: TextFormField(
                                                      controller:
                                                          option.roadState,
                                                      keyboardType:
                                                          TextInputType
                                                              .streetAddress,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // District nane
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Bairro'),
                                      ),
                                      const SizedBox(height: 10),
                                      // District form
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Container(
                                                width: 270,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 170, 221, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 270,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextFormField(
                                                  controller:
                                                      option.roadDistrict,
                                                  keyboardType: TextInputType
                                                      .streetAddress,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // CEP name
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('CEP'),
                                      ),
                                      const SizedBox(height: 10),
                                      // CEP form
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Container(
                                                width: 270,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 170, 221, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 270,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextFormField(
                                                  controller: option.roadCEP,
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Contact name
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Número'),
                                      ),
                                      const SizedBox(height: 10),
                                      // Contact form
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: Container(
                                                width: 270,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 170, 221, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 270,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextFormField(
                                                  controller:
                                                      option.roadContact,
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Upload
                                      Container(
                                        alignment: Alignment.center,
                                        width: 290,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              //incorrect road
                                              if (option.roadName.text.length <=
                                                  5) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'O nome da sua rua pode estar errado'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              //incorrect number
                                              if (option.roadNumber.text ==
                                                  '') {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'Você precisa preencher o campo Número'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              //incorrect state
                                              if (option
                                                      .roadState.text.length <=
                                                  1) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'Você precisa preencher corretamente o estado'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              //incorrect district
                                              if (option.roadDistrict.text
                                                      .length <=
                                                  1) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'Você precisa preencher corretamento o Bairro'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              //incorrect CEP
                                              if (option.roadCEP.text.length <
                                                      8 ||
                                                  option.roadCEP.text.length >
                                                      8) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'CEP precisa ter 8 digitos e apenas números'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              //incorrect contact
                                              if (option.roadContact.text
                                                          .length <
                                                      10 ||
                                                  option.roadContact.text
                                                          .length >
                                                      11) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Ops'),
                                                        content: const Text(
                                                            'O numero é inválido'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AlertDialog(
                                                      title: Text('Carregando'),
                                                      content: FittedBox(
                                                        child: SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                    );
                                                  });
                                              await addNewLocation({
                                                "roadName":
                                                    option.roadName.text,
                                                "houseNumber":
                                                    option.roadNumber.text,
                                                "state": option.roadState.text,
                                                "district":
                                                    option.roadDistrict.text,
                                                "CEP": option.roadCEP.text,
                                                "contactNumber":
                                                    option.roadContact.text
                                              });
                                            },
                                            child: const Text('Enviar')),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(Icons.add_home_outlined),
                        SizedBox(width: 10),
                        Text('Adicionar Lugar'),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Delivery locations
              FutureBuilder(
                  future: pushDelivery(),
                  builder: (context, future) {
                    if (future.hasData) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: future.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: FittedBox(
                              child: Container(
                                width: 240,
                                height: 246,
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Road name
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                          right: 1,
                                        ),
                                        child: SizedBox(
                                          height: 45,
                                          child: Text(
                                            'Rua: ${future.data!['Delivery$i']['roadName']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      //House number
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                        ),
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(
                                            'Numero: ${future.data!['Delivery$i']['houseNumber']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      //State
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                        ),
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(
                                            'Estado: ${future.data!['Delivery$i']['state']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      //District
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                        ),
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(
                                            'Bairro: ${future.data!['Delivery$i']['district']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      //CEP
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                        ),
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(
                                            'CEP: ${future.data!['Delivery$i']['CEP']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      //Contact number
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                        ),
                                        child: SizedBox(
                                          height: 45,
                                          child: Text(
                                            'Numero de contato: ${future.data!['Delivery$i']['contactNumber']}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      //Remove Location
                                      Row(
                                        children: [
                                          const Spacer(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Remover Local'),
                                                    content: const Text(
                                                        'Tem certeza?'),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          await removeDelivery(
                                                              i);
                                                        },
                                                        child:
                                                            const Text('Sim'),
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child:
                                                              const Text('Não'))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Remover Local'),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      //Loading
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
