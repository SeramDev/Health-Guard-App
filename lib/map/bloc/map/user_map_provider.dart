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
                latitude: 8.76103431484167, longitude: 80.50497200778406),
            policeLocation: PoliceLocation(
                latitude: 9.321431814287571, longitude: 80.40737614408987),
            ambulanceLocation: AmbulanceLocation(
                latitude: 8.934514394256126, longitude: 80.0013611233864)));

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
