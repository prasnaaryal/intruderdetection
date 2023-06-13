
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    required this.tapEvent,
    super.key,
  });

  final GestureTapCallback tapEvent;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: tapEvent,
    );
  }
}