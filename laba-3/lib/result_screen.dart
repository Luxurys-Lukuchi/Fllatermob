import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double capital;
  final int years;
  final double rate;

  const ResultScreen({
    super.key,
    required this.capital,
    required this.years,
    required this.rate,
  });

  double _calculate() => capital * (1 + (rate / 100) * years);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Исходный капитал: ${capital.toStringAsFixed(2)} руб'),
            Text('Срок: $years лет'),
            Text('Ставка: ${rate.toStringAsFixed(2)}%'),
            const SizedBox(height: 20),
            Text(
              'Итоговая сумма: ${_calculate().toStringAsFixed(2)} руб',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}