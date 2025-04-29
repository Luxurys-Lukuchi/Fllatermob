import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'database/db_provider.dart';
import 'cubit/interest_cubit.dart';
import 'screens/input_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbProvider = DBProvider.db;
  runApp(MyApp(dbProvider: dbProvider));
}

class MyApp extends StatelessWidget {
  final DBProvider dbProvider;

  const MyApp({super.key, required this.dbProvider});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterestCubit(dbProvider),
      child: MaterialApp(
        title: 'Cubit Проценты',
        theme: ThemeData(primarySwatch: Colors.blue),
        home:  InputScreen(),
      ),
    );
  }
}
