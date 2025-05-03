import '../models/photo.dart';

class NasaResponse {
  final List<Photo> photos;

  NasaResponse({required this.photos});

  factory NasaResponse.fromJson(Map<String, dynamic> json) {
    var photosList = json['photos'] as List;
    return NasaResponse(
      photos: photosList.map((photo) => Photo.fromJson(photo)).toList(),
    );
  }
}