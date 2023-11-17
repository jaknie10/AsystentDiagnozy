import 'package:flutter/material.dart';

import 'patient_profile.dart';

class PatientListItem extends StatefulWidget {
  const PatientListItem({
    Key? key,
    required this.name,
    required this.surname,
    required this.gender,
    required this.id,
  }) : super(key: key);

  final String name;
  final String surname;
  final String gender;
  final int id;

  @override
  State<PatientListItem> createState() => _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  @override
  Widget build(BuildContext context) {
    DateTime dataUrodzenia = DateTime.utc(2000, 10, 10);
    int age = DateTime.now().difference(dataUrodzenia).inDays ~/ 365;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Material(
        child: InkWell(
          child: Ink(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white),
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
                          widget.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(" "),
                        Text(
                          widget.surname,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(dataUrodzenia.toString().substring(0, 10), style: const TextStyle(fontSize: 18)),
                            ),
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
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  age.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextButton(
                      //       onPressed: () async {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => PatientProfile(
                      //               patientId: widget.id,
                      //               patientGender: widget.gender,
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       style: IconButton.styleFrom(
                      //         highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                      //         backgroundColor: Theme.of(context).colorScheme.primary,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.0),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         'test',
                      //         style: TextStyle(color: Colors.white, fontSize: 15),
                      //       )),
                      // ),
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
                  patientId: widget.id,
                  patientGender: widget.gender,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
