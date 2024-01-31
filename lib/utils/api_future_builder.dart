import 'package:flutter/material.dart';

class GeneralFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget? placeHolder;
  final Widget Function(BuildContext context, T data) builder;

  const GeneralFutureBuilder(
      {Key? key, required this.future, required this.builder, this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return builder(context, snapshot.data as T);
          } else {
            return const Center(
              child: Text("Data has not found"),
            );
          }
        } else {
          return Center(
            child: placeHolder ?? const CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
