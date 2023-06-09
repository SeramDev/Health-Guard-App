import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/map/ui_controllers/controllers.dart';

import '../bloc/map/user_map_provider.dart';

class MapLoadingProgressIndicator extends StatelessWidget {
  const MapLoadingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isMapLoaded,
        builder: (context, value, child) {
          return (isMapLoaded.value == true)
              ? const SizedBox.shrink()
              : Container(
                  width: 170.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Loading",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ));
        });
  }
}
