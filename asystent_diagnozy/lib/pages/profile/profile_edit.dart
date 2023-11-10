import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  final int doctorId;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: [
            Text(
                'DoctorProfileEdit' +
                    " DoctorId:" +
                    widget.doctorId.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, widget.doctorId);
                },
                child: Text("Powrót"))
          ],
        ),
      ),
    );
  }
}
