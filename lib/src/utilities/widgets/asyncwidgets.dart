import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncErrorWidget extends StatelessWidget {
  const AsyncErrorWidget({
    Key? key,
    required this.ref,
    required this.onRefresh,
    required this.errorMessage,
  }) : super(key: key);

  final WidgetRef ref;
  final String errorMessage;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
         Text(
          errorMessage,
          style:const TextStyle(color: Colors.red),
        ),
        IconButton(
          onPressed: () => onRefresh(),
          icon: const Icon(
            Icons.refresh,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}


class AsyncLoadingWidget extends StatelessWidget {
  const AsyncLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
