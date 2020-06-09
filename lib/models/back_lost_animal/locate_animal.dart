import 'package:geolocator/geolocator.dart';

Future<Position> locateAnimal() async {
  return Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
