import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
    child: Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 255, 153, 0),
      child: const Center(
        child: Text('HomePage'),
      ),
    ),
          );
  }
}
