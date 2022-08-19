import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/direction.dart';
import 'location_service.dart';

class DirectionRepository {
  static const url = "https/googleapis.com/maps/directions/json?";
  final Dio _dio;
  DirectionRepository({Dio? dio}) : _dio = dio!;

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': GOOGLE_API_KEY
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    print("Error");
    return null;
  }
}
