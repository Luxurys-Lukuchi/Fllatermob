import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/interest_cubit.dart';
import '../cubit/interest_state.dart';
import 'history_screen.dart';

class InputScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _capitalController = TextEditingController();
  final _termController = TextEditingController();
  final _rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нечталенко Илья Антонович'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<InterestCubit>(context),
                    child: const HistoryScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<InterestCubit, InterestState>(
        listener: (context, state) {
          if (state is InterestError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final agreed = state is InterestAgreementUpdated 
              ? state.agreed 
              : (state is InterestCalculated ? state.agreed : false);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _capitalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Капитал (руб)'),
                    validator: (value) => value!.isEmpty ? 'Обязательное поле' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _termController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Срок (лет)'),
                    validator: (value) => value!.isEmpty ? 'Обязательное поле' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Ставка (%)'),
                    validator: (value) => value!.isEmpty ? 'Обязательное поле' : null,
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Согласен на обработку данных'),
                    value: agreed,
                    onChanged: (value) {
                      context.read<InterestCubit>().setAgreed(value!);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && agreed) {
                        context.read<InterestCubit>().calculateInterest(
                          capital: double.parse(_capitalController.text),
                          term: double.parse(_termController.text),
                          rate: double.parse(_rateController.text),
                        );
                      } else if (!agreed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Необходимо дать согласие на обработку данных'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Рассчитать', style: TextStyle(fontSize: 18)),
                  ),
                  if (state is InterestCalculated) ...[
                    const SizedBox(height: 30),
                    Text(
                      'Результат:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text('Капитал: ${state.capital.toStringAsFixed(2)} руб'),
                    Text('Срок: ${state.term} лет'),
                    Text('Ставка: ${state.rate}%'),
                    const SizedBox(height: 10),
                    Text(
                      'Проценты: ${state.interest.toStringAsFixed(2)} руб',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _capitalController.clear();
                        _termController.clear();
                        _rateController.clear();
                        context.read<InterestCubit>().reset();
                      },
                      child: const Text('Сброс'),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}