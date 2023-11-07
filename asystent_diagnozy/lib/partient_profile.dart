import 'package:flutter/material.dart';

import 'patient_list_item.dart';
import 'badanie_list_item.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key, required this.changeState}) : super(key: key);

  final changeState;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  int age =
      DateTime.now().difference(DateTime(2000, 10, 10, 00, 01)).inDays ~/ 365;

  String sortingType = 'Data badania (rosnąco)';

  List<DropdownMenuItem<String>> sortingOptions = [
    const DropdownMenuItem(
        value: "Data badania (rosnąco)", child: Text("Data badania (rosnąco)")),
    const DropdownMenuItem(
        value: "Data badania (malejąco)",
        child: Text("Data badania (malejąco)")),
    const DropdownMenuItem(value: "A-Z", child: Text("A-Z")),
    const DropdownMenuItem(value: "Z-A", child: Text("Z-A")),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: PatientListItem(
                imie: "Jan",
                nazwisko: "Kowalski",
                dataUrodzenia: DateTime(2000, 10, 10),
                gender: "M",
                changeState: widget.changeState,
                showDateOfBirth: true,
                buttonText: "Edytuj Profil",
                buttonAction: "patientEditProfile"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          "Dodaj nowe badanie",
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                  Container(
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: SizedBox(
                              width: 150,
                              child: Image(
                                  image: AssetImage(
                                      'assets/morfologia_logo.png'))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: SizedBox(
                              width: 150,
                              child: Image(
                                  image: AssetImage(
                                      'assets/elektroforeza_logo.png'))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(22, 20, 35, 1.0)),
                        elevation: 0,
                        value: sortingType,
                        items: sortingOptions,
                        onChanged: (val) {
                          setState(() {
                            sortingType = val.toString();
                          });
                          debugPrint(sortingType);
                        }),
                  ),
                ),
              ),
            ),
          ),
          const BadanieListItem(),
        ],
      ),
    );
  }
}
