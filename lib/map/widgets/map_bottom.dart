import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/map/bloc/detail/user_detail_provider.dart';
import 'package:health_guard/map/services/deatail_services/user_detail_service.dart';

/*
showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
 */
class MapBottom extends ConsumerStatefulWidget {
  const MapBottom({super.key});

  @override
  ConsumerState<MapBottom> createState() => _MapBottomState();
}

class _MapBottomState extends ConsumerState<MapBottom> {
  @override
  void initState() {
    ref.read(userDetailProvider.notifier).getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var details = ref.watch(userDetailProvider);
    //print(details);
    if (details is SuccessUserDetailState) {
      return onDetails(details.userDetail);
    } else {
      return onLoading();
    }
  }

  Widget onLoading() {
    return Container(
      height: 200,
      color: Colors.amber,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget onDetails(UserDetailModel details) {
    return Container(
      height: 400,
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('dbp:  ${details.diastolicBloodPressure}'),
            Text('heart rate;  ${details.heartRate}'),
            Text('os:  ${details.oxygenSaturation}'),
            ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
