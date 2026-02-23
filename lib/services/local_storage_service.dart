import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class LocalStorageService {
  static const likedKey = 'liked_products';
  static const historyKey = 'browsing_history';

  Future<void> saveLikedProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final liked = products.where((p) => p.isLiked).map((p) => json.encode(p.toJson())).toList();
    await prefs.setStringList(likedKey, liked);
  }

  Future<List<int>> getLikedProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final liked = prefs.getStringList(likedKey) ?? [];
    return liked.map((e) => json.decode(e)['id'] as int).toList();
  }

  Future<void> saveVisitedUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(historyKey) ?? [];
    history.add(url);
    await prefs.setStringList(historyKey, history);
  }

  Future<List<String>> getBrowsingHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(historyKey) ?? [];
  }
}
