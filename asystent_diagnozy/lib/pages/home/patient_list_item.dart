import 'package:asystent_diagnozy/models/patient.dart';
import 'package:flutter/material.dart';

import 'patient_profile.dart';

class PatientListItem extends StatefulWidget {
  const PatientListItem({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientListItem> createState() => _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  @override
  Widget build(BuildContext context) {
    DateTime birthdayDate = DateTime.parse(widget.patient.birthDate);
    int age = DateTime.now().difference(birthdayDate).inDays ~/ 365;

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: Material(
        child: InkWell(
          child: Ink(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Text(
                          widget.patient.surname,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(" "),
                        Text(
                          widget.patient.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                  birthdayDate.toString().substring(0, 10),
                                  style: const TextStyle(fontSize: 18)),
                            ),
                            widget.patient.gender == "M"
                                ? const ImageIcon(
                                    AssetImage('assets/gender_male.png'),
                                  )
                                : const ImageIcon(
                                    AssetImage('assets/gender_female.png'),
                                  ),
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  age.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientProfile(
                  patient: widget.patient,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
