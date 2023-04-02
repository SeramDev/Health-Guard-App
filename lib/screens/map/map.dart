import 'package:flutter/cupertino.dart';
import 'package:health_guard/components/custom_text.dart';
import 'package:health_guard/utils/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        "Map Screen",
        color: AppColors.kBalck,
        fontSize: 20,
      ),
    );
  }
}
