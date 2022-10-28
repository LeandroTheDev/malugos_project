class Product {
  final String name;
  final String description;
  final double price;
  final String imageURL;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.imageURL = '',
  });
}

final dummyproducts = [
  Product(
    name: 'Cadeira Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 812.24,
    imageURL: '',
  ),
  Product(
    name: 'Teclado Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 201.10,
    imageURL: '',
  ),
  Product(
    name: 'Mouse Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 212.32,
    imageURL: '',
  ),
  Product(
    name: 'MousePad RGB',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 103.15,
    imageURL: '',
  ),
  Product(
    name: 'Head Set Razer Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 431.53,
    imageURL: '',
  ),
];
