import 'package:flutter/material.dart';
import 'result_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _capitalController = TextEditingController();
  final _yearsController = TextEditingController();
  final _rateController = TextEditingController();
  bool _agreement = false;

  void _calculateAndNavigate() {
    if (_formKey.currentState!.validate() && _agreement) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            capital: double.parse(_capitalController.text),
            years: int.parse(_yearsController.text),
            rate: double.parse(_rateController.text),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нечталенко Илья ИВТ-22 вариант 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Капитал (руб)'),
                validator: (value) => value!.isEmpty ? 'Введите сумму' : null,
              ),
              TextFormField(
                controller: _yearsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Срок (лет)'),
                validator: (value) => value!.isEmpty ? 'Введите срок' : null,
              ),
              TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ставка (%)'),
                validator: (value) => value!.isEmpty ? 'Введите ставку' : null,
              ),
              CheckboxListTile(
                title: const Text('Согласен на обработку данных'),
                value: _agreement,
                onChanged: (bool? value) => setState(() => _agreement = value!),
              ),
              ElevatedButton(
                onPressed: _calculateAndNavigate,
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}