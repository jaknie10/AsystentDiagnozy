import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
    child: Container(
      width: double.infinity,
      color: Color.fromARGB(255, 21, 100, 255),
      child: const Center(
        child: Text('Profile'),
      ),
    ),
    );
  }
}
