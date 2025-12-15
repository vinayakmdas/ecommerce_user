import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationDataSources {

    Future<Position>getCurrentPossition()async{
      LocationPermission permission = await Geolocator.checkPermission();

      if(permission==LocationPermission.denied){
        permission = await Geolocator.requestPermission();
      }
      if(permission==LocationPermission.deniedForever){
        throw Exception('Location permission denied forever');
      }
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
     Future<List<Placemark>> getPlacemarkFromPosition(double lat, double lon) async {
    return await placemarkFromCoordinates(lat, lon);
  }
}