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
    price: 154.24,
    imageURL: '',
  )
];
