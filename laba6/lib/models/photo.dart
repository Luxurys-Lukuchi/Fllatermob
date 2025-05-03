import '../models/rover.dart';
import '../models/camera.dart';

class Photo {
  final int id;
  final int sol;
  final Camera camera;
  final String imgSrc;
  final String earthDate;
  final Rover rover;

  Photo({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
  });

  
  String get safeImgSrc {
    
    return imgSrc
        .replaceFirst('http://mars.jpl.nasa.gov', 'https://mars.nasa.gov')
        .replaceFirst('http://', 'https://');
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      sol: json['sol'],
      camera: Camera.fromJson(json['camera']),
      imgSrc: json['img_src'] ?? 'https://via.placeholder.com/300x200?text=No+Image',
      earthDate: json['earth_date'],
      rover: Rover.fromJson(json['rover']),
    );
  }
}
