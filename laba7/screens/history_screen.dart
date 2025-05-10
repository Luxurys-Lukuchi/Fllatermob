import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<String>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _getHistory();
  }

  Future<List<String>> _getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('history') ?? [];
  }

  Future<void> _deleteHistoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('history') ?? [];
    if (index < history.length) {
      history.removeAt(index);
      await prefs.setStringList('history', history);
      setState(() {
        _historyFuture = _getHistory(); // Обновляем список
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setStringList('history', []);
              setState(() {
                _historyFuture = _getHistory();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final history = snapshot.data!;
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteHistoryItem(index),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("История пуста"));
          }
        },
      ),
    );
  }
}