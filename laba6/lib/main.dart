import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';
import 'cubit/nasa_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => NasaCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Выполнил Нечталенко И.А.',
              style: TextStyle(fontSize: 16), // Настройка стиля текста
            ),
          ),
          body: const HomeScreen(), // Основной экран приложения
        ),
      ),
    );
  }
}