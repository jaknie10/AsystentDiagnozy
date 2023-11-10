import 'package:flutter/material.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  final int patientId;

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class _PatientEditProfileState extends State<PatientEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: [
            Text(
                'PatientEditProfile' +
                    " PatientId:" +
                    widget.patientId.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, widget.patientId);
                },
                child: Text("Powrót"))
          ],
        ),
      ),
    );
  }
}
