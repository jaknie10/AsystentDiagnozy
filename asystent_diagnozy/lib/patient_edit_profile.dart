import 'package:flutter/material.dart';

class PatientEditProfile extends StatelessWidget {
  const PatientEditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
    child: Container(
      width: double.infinity,
      color: Colors.cyan,
      child: const Center(
        child: Text('PatientEditProfile'),
      ),
    ),
    );
  }
}
