import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/map/services/deatail_services/user_detail_service.dart';

abstract class UserDetailState {}

class LoadingUserDetailState extends UserDetailState {}

class SuccessUserDetailState extends UserDetailState {
  final UserDetailModel userDetail;

  SuccessUserDetailState({required this.userDetail});
}

class ErrorUserDetailState extends UserDetailState {}

class UserDetailNotifier extends StateNotifier {
  UserDetailNotifier(super.state);

  void getUserDetail() async {
    UserDetailServiceResult userDetailServiceResult = await getUserDetails();
    if (userDetailServiceResult is SuccessUserDetailServiceResult) {
      state = SuccessUserDetailState(
          userDetail: userDetailServiceResult.userDetailModel);
    } else {
      state = ErrorUserDetailState();
    }
  }
}

final userDetailProvider = StateNotifierProvider(
    (ref) => UserDetailNotifier(LoadingUserDetailState()));
