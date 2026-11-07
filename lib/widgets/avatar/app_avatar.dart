import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;

  const AppAvatar({super.key, required this.name, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      child: Text(name.isNotEmpty ? name[0].toUpperCase() : ''),
    );
  }
}
