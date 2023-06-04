import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/map/detail_bloc/detail_provider.dart';

import 'widgets/loading_indicator.dart';
import 'widgets/map_bottom.dart';
import 'service/geolocator.dart';
import 'map_bloc/map_provider.dart';
import 'widgets/map_section.dart';

enum UserType { accidentUser, policeUser, ambulanceUser }

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key, required this.userType});

  final UserType userType;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  Timer? timer;

  @override
  void initState() {
    var mapNotifier = ref.read(mapProvider.notifier);
    mapNotifier.intilizeMap(widget.userType);
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      mapNotifier.updateMapMarkers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    var mapNotifier = ref.read(mapProvider.notifier);

    var detailProviderState = ref.watch(detailProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MapSection(
                  userType: widget.userType,
                ),
                const Center(child: MapLoadingProgressIndicator()),
                (detailProviderState is HideDetailState)
                    ? const SizedBox.shrink()
                    : MapBottom(), //use simple valuenotifier to show and hide
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        mapNotifier.intilizeMap(widget.userType);
      }),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}