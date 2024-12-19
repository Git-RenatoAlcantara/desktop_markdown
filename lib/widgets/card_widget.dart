import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;

  const CardWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(title),
    );
  }
}
