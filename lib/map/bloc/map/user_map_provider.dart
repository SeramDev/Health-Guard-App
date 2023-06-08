import 'package:health_guard/map/services/map_services/location_update_service.dart';
import 'package:riverpod/riverpod.dart';

abstract class UserMapState {
  final UserLocation userLocation;
  final PoliceLocation policeLocation;
  final AmbulanceLocation ambulanceLocation;

  UserMapState(
      {required this.userLocation,
      required this.policeLocation,
      required this.ambulanceLocation});
}

class UserLoadingMapState extends UserMapState {
  UserLoadingMapState(
      {required super.userLocation,
      required super.policeLocation,
      required super.ambulanceLocation});
}

class UserSuccessMapState extends UserMapState {
  UserSuccessMapState(
      {required super.userLocation,
      required super.policeLocation,
      required super.ambulanceLocation});
}

class UserErrorMapState extends UserMapState {
  UserErrorMapState(
      {required super.userLocation,
      required super.policeLocation,
      required super.ambulanceLocation});
}

class UserMapNotifier extends StateNotifier {
  final Ref ref;

  UserMapNotifier(this.ref)
      : super(UserLoadingMapState(
            userLocation: UserLocation(
                latitude: 0.0, longitude: 0.0),
            policeLocation: PoliceLocation(
                latitude: 0.0, longitude: 0.0),
            ambulanceLocation: AmbulanceLocation(
                latitude: 0.0, longitude: 0.0)));

  // This method is called by location bloc
  Future<bool> updateMapMarkers({required String uid}) async {
    // 1 - call async services and get data

    var result = await updateAndRequestLoacations(uid: uid);

    if (result is SuccessResult) {
      state = UserSuccessMapState(
          userLocation: result.userLocation,
          policeLocation: result.policeLocation,
          ambulanceLocation: result.ambulanceLocation);
      return true;
    } else {
      return false;
    }
  }
}

final userMapProvider = StateNotifierProvider((ref) => UserMapNotifier(ref));
