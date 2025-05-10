import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laba7/cubits/weather_cubit.dart';
import 'package:laba7/screens/about_screen.dart';
import 'package:laba7/screens/history_screen.dart';
import 'wind_map_screen.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Введите город',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.read<WeatherCubit>().fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded) {
                    final weather = state.weather;
                    final unit = state.isMetric ? 'м/с' : 'км/ч';
                    final speed = state.isMetric ? weather.windSpeedMps : weather.windSpeedMps * 3.6;

                    return ListView(
                      children: [
                        Center(child: Text(weather.description, style: const TextStyle(fontSize: 24))),
                        const SizedBox(height: 16),
                        Text('Температура: ${weather.temp}°C'),
                        Text('Давление: ${weather.pressure} гПа'),
                        Text('Влажность: ${weather.humidity}%'),
                        Text('Видимость: ${weather.visibility} м'),
                        Text('Облачность: ${weather.clouds}%'),
                        Text('Ветер: ${speed.toStringAsFixed(1)} $unit (направление ${weather.windDeg}°)'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.sync),
                              onPressed: () => context.read<WeatherCubit>().toggleUnit(),
                            ),
                            const Text('Переключить м/с на км/ч'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const WindMapScreen()),
                            );
                          },
                          child: const Text('Открыть карту ветров'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const HistoryScreen()),
                            );
                          },
                          child: const Text('Посмотреть историю'),
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(child: Text('Ошибка: ${state.message}'));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
              child: const Text(
                'О разработчике',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}