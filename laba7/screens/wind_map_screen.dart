import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../cubits/weather_cubit.dart';

class WindMapScreen extends StatefulWidget {
  const WindMapScreen({super.key});

  @override
  State<WindMapScreen> createState() => _WindMapScreenState();
}

class _WindMapScreenState extends State<WindMapScreen> {
  final MapController _mapController = MapController();
  late String _apiKey;
  LatLng? _initialCenter;

  @override
  void initState() {
    super.initState();
    final weatherCubit = context.read<WeatherCubit>();
    _apiKey = weatherCubit.apiKey;
    if (weatherCubit.currentWeather != null) {
      _initialCenter = LatLng(
        weatherCubit.currentWeather!.lat,
        weatherCubit.currentWeather!.lon,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherCubit>().currentWeather;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта ветров OpenWeather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: weather != null 
                ? () => _centerMapOnLocation(weather.lat, weather.lon)
                : null,
            tooltip: 'Вернуться к текущему местоположению',
          ),
        ],
      ),
      body: weather == null
          ? const Center(child: Text('Сначала загрузите данные о погоде'))
          : _buildWindMap(),
    );
  }

  Widget _buildWindMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: _initialCenter ?? const LatLng(51.509364, -0.128928),
        zoom: 5.0,
        minZoom: 2,
        maxZoom: 10,
      ),
      children: [
        
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        
  Opacity(
    opacity: 0.7, 
    child: TileLayer(
      urlTemplate: 'https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=$_apiKey',
    ),
  ),
      ],
    );
  }

  void _centerMapOnLocation(double lat, double lon) {
    _mapController.move(LatLng(lat, lon), _mapController.zoom);
  }
}
