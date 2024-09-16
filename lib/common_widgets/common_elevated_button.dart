import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String buttonName;
  final void Function() onPressed;

  const CommonElevatedButton(
      {super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(onPressed: onPressed, child: Text(buttonName)),
    );
  }
}
