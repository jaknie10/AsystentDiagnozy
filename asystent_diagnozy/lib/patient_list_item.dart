import 'package:flutter/material.dart';

import 'patient_profile.dart';

class PatientListItem extends StatefulWidget {
  const PatientListItem({
    Key? key,
    required this.imie,
    required this.nazwisko,
    required this.dataUrodzenia,
    required this.gender,
    required this.showDateOfBirth,
    required this.buttonText,
    required this.id,
  }) : super(key: key);

  final String imie;
  final String nazwisko;
  final DateTime dataUrodzenia;
  final String gender;
  final bool showDateOfBirth;
  final String buttonText;
  final int id;

  @override
  State<PatientListItem> createState() => _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  @override
  Widget build(BuildContext context) {
    int age = DateTime.now().difference(widget.dataUrodzenia).inDays ~/ 365;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      widget.imie,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(" "),
                    Text(
                      widget.nazwisko,
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
                        widget.showDateOfBirth
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                    widget.dataUrodzenia
                                        .toString()
                                        .substring(0, 10),
                                    style: const TextStyle(fontSize: 15)),
                              )
                            : const Text(""),
                        widget.gender == "M"
                            ? const ImageIcon(
                                AssetImage('assets/gender_male.png'),
                              )
                            : const ImageIcon(
                                AssetImage('assets/gender_female.png'),
                              ),
                        SizedBox(
                          width: 80,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              age.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientProfile(patientId: widget.id),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          widget.buttonText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
