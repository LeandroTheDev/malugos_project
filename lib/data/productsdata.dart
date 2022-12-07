class Product {
  final int id;
  final String name;
  final String nameFull;
  final String description;
  final double price;
  final String imageURL;
  final String category;

  Product({
    this.id = 0,
    required this.name,
    required this.description,
    required this.price,
    this.nameFull = '',
    this.imageURL = '',
    this.category = '',
  });
}
