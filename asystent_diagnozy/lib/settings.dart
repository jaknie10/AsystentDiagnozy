import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
    child: Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 21, 0, 255),
      child: const Center(
        child: Text('Settings'),
      ),
    ),
    );
  }
}
