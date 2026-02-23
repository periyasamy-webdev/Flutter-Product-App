import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorageService();

    return Scaffold(
      appBar: AppBar(title: const Text('Browsing History')),
      body: FutureBuilder<List<String>>(
        future: storage.getBrowsingHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final history = snapshot.data!;
          if (history.isEmpty) return const Center(child: Text('No history yet'));
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) => ListTile(title: Text(history[index])),
          );
        },
      ),
    );
  }
}
