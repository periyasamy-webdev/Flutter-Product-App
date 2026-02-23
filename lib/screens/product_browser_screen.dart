import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/local_storage_service.dart';

class ProductBrowserScreen extends StatefulWidget {
  final String url;
  const ProductBrowserScreen({super.key, required this.url});

  @override
  State<ProductBrowserScreen> createState() => _ProductBrowserScreenState();
}

class _ProductBrowserScreenState extends State<ProductBrowserScreen> {
  final storage = LocalStorageService();
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) => storage.saveVisitedUrl(url),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Browser')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
