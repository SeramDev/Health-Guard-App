import 'package:flutter/material.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/map_section.dart';

class NewUserMapScreen extends StatelessWidget {
  const NewUserMapScreen({super.key, required this.userType});

  final UserType userType;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MapSection(
                  userType: userType,
                ),
                const Center(child: MapLoadingProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}
