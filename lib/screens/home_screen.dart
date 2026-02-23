import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../widgets/product_card.dart';
import 'product_browser_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();
  final storage = LocalStorageService();
  List<Product> products = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final fetched = await api.fetchProducts();
      final likedIds = await storage.getLikedProductIds();
      for (var p in fetched) {
        p.isLiked = likedIds.contains(p.id);
      }
      setState(() {
        products = fetched;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  void toggleLike(Product product) {
    setState(() => product.isLiked = !product.isLiked);
    storage.saveLikedProducts(products);
  }

  void openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductBrowserScreen(url: 'https://fakestoreapi.com/products/${product.id}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text(error!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadProducts,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ProductCard(
            product: products[index],
            onLike: () => toggleLike(products[index]),
            onOpen: () => openProduct(products[index]),
          ),
        ),
      ),
    );
  }
}
