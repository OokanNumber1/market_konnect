import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/interview_prep/firestore_service/firestore_service.dart';

class CustomStreamView extends StatefulWidget {
  const CustomStreamView({super.key});

  @override
  State<CustomStreamView> createState() => _CustomStreamViewState();
}

class _CustomStreamViewState extends State<CustomStreamView> {
  // Stream<List<int>> getCustomStream() {
  //   final numbers = [1, 22, 333, 4444];
  //   List<int> lstNum = [9];

  //   for (int number in numbers) {
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       Timer.periodic(const Duration(milliseconds: 500), (timer) {
  //         lstNum.add (number);
  //       });
  //     });
  //   }

  //   return Stream.fromIterable(lstNum);
  // }

  Stream<int> timedCounter() {
    final controller = StreamController<int>();
    final numbers = [1, 22, 333, 4444];

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      for (int number in numbers) {
        controller.add(number);
      }
    });

    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<int>(
          stream: timedCounter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Icon(Icons.error),
              );
            }
            return Text(snapshot.data!.toString());
          },
        ),
      ),
    );
  }
}

class CustomStreamPrvder extends ConsumerStatefulWidget {
  const CustomStreamPrvder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomStreamPrvderState();
}

class _CustomStreamPrvderState extends ConsumerState<CustomStreamPrvder> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(strmPrvder);
    return Scaffold(
      body: SafeArea(
          child: provider.when(
        data: (data) {
          return Column(
            children: List.generate(
              data.length,
              (index) => Text(data[index].name),
            ),
          );
        },
        error: (_, __) => const Center(
          child: Icon(Icons.error),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }
}
