import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/interest_cubit.dart';
//import '../models/calculation.dart';
import 'package:intl/intl.dart';
import '../cubit/interest_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Загружаем историю при открытии экрана
    context.read<InterestCubit>().loadHistory();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('История расчетов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<InterestCubit>().clearHistory();
            },
          ),
        ],
      ),
      body: BlocBuilder<InterestCubit, InterestState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            final calculations = state.calculations;
            if (calculations.isEmpty) {
              return const Center(child: Text('Нет сохраненных расчетов'));
            }
            return ListView.builder(
              itemCount: calculations.length,
              itemBuilder: (context, index) {
                final calc = calculations[index];
                return Dismissible(
                  key: Key(calc.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    context.read<InterestCubit>().deleteCalculation(calc.id!);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy HH:mm').format(calc.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text('Капитал: ${calc.capital.toStringAsFixed(2)} руб'),
                          Text('Срок: ${calc.term} лет'),
                          Text('Ставка: ${calc.rate}%'),
                          const SizedBox(height: 8),
                          Text(
                            'Проценты: ${calc.interest.toStringAsFixed(2)} руб',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
