import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/new_fetcher/bloc/new_fetch.dart';
import 'package:health_guard/models/objects.dart';

class FetchTestScreen extends ConsumerWidget {
  const FetchTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(alertStateProvider.notifier);
    var state = ref.watch(alertStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('status:  ${(state as SensorDataModel).status}'),
          // ),
          ElevatedButton(
              onPressed: () {
                notifier.fetchUserData(context);
              },
              child: Text("fetch user data")),
          ElevatedButton(
              onPressed: () {
                notifier.incrementCancel();
              },
              child: Text("cancel")),
        ],
      ),
    );
  }
}
