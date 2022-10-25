import 'package:flutter/material.dart';

class LoadingAlert extends StatelessWidget {
  String message;
  LoadingAlert({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(message),
          )
        ],
      ),
    );
  }
}
