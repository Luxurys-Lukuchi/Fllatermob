part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final bool isMetric;

  WeatherLoaded({required this.weather, required this.isMetric});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
