import 'package:flutter/cupertino.dart';

class AmbulanceMapScreen extends StatefulWidget {
  const AmbulanceMapScreen({super.key});

  @override
  State<AmbulanceMapScreen> createState() => _AmbulanceMapScreenState();
}

class _AmbulanceMapScreenState extends State<AmbulanceMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Ambulance map should come here"),
        ],
      ),
    );
  }
}
