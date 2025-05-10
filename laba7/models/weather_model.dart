class WeatherModel {
  final String description;
  final double windSpeedMps;
  final int windDeg;
  final double temp;
  final int humidity;
  final int pressure;
  final int visibility;
  final int clouds;
  final double lat;
  final double lon;

  WeatherModel({
    required this.description,
    required this.windSpeedMps,
    required this.windDeg,
    required this.temp,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.clouds,
    required this.lat,
    required this.lon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      windSpeedMps: (json['wind']['speed'] as num).toDouble(),
      windDeg: (json['wind']['deg'] as num).toInt(),
      temp: (json['main']['temp'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      pressure: (json['main']['pressure'] as num).toInt(),
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      clouds: (json['clouds']['all'] as num).toInt(),
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }
}
