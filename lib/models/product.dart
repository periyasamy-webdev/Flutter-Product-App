class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  bool isLiked;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.isLiked = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: (json['price'] as num).toDouble(),
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'image': image,
        'isLiked': isLiked,
      };
}
