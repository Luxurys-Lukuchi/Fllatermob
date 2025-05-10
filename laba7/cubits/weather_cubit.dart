import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

part 'weather_state.dart';


class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  bool isMetric = true;
  WeatherModel? currentWeather;
  final apiKey = 'fb20be23c8ebdec3a848edf912ebf11a';

  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      final weather = WeatherModel.fromJson(data);
      currentWeather = weather;

      final prefs = await SharedPreferences.getInstance();
      List<String> history = prefs.getStringList('history') ?? [];
      history.add('$cityName - ${DateTime.now().toIso8601String()}');
      await prefs.setStringList('history', history);

      emit(WeatherLoaded(weather: weather, isMetric: isMetric));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }

  void toggleUnit() {
    if (currentWeather != null) {
      isMetric = !isMetric;
      emit(WeatherLoaded(weather: currentWeather!, isMetric: isMetric));
    }
  }
}
