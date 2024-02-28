import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/new_fetcher/bloc/new_fetch.dart';

class FetchTestScreen extends ConsumerWidget {
  const FetchTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(alertStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                notifier.fetchUserData(context);
              },
              child: const Text("fetch user data")),
          ElevatedButton(
              onPressed: () {
                notifier.incrementCancel();
              },
              child: const Text("cancel")),
        ],
      ),
    );
  }
}
