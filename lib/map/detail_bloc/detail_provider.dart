import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/map/service/data.dart';

abstract class DetailState {}

class HideDetailState extends DetailState {}

class ShowDetailState extends DetailState {
  final AccidentUserDetails accidentUserDetails;

  ShowDetailState({required this.accidentUserDetails});
}

final detailProvider = StateProvider<DetailState>((ref) => HideDetailState());
