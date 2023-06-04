import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../map_bloc/map_provider.dart';

class MapLoadingProgressIndicator extends ConsumerWidget {
  const MapLoadingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mapState = ref.watch(mapProvider);
    return (mapState is SuccessMapState)
        ? const SizedBox.shrink()
        : Container(
            width: 170.0,
            height: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Loading",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ));
  }
}