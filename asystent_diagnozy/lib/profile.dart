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
      color: const Color.fromARGB(255, 225, 17, 44),
      child: const Center(
        child: Text('Profile'),
      ),
    ),
    );
  }
}
