import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onLike;
  final VoidCallback onOpen;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onLike,
    required this.onOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Image.network(product.image, width: 50, height: 50),
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: Icon(
            product.isLiked ? Icons.favorite : Icons.favorite_border,
            color: product.isLiked ? Colors.red : null,
          ),
          onPressed: onLike,
        ),
        onTap: onOpen,
      ),
    );
  }
}
