import 'package:flutter/material.dart';

import 'patient_list_item.dart';

class Patient {
  final String imie;
  final String nazwisko;
  final DateTime dataUrodzenia;
  final String gender;
  final bool showDateOfBirth;
  final String buttonText;
  final String buttonAction;

  Patient(
      {required this.imie,
      required this.nazwisko,
      required this.dataUrodzenia,
      required this.gender,
      required this.showDateOfBirth,
      required this.buttonText,
      required this.buttonAction});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.changeState}) : super(key: key);

  final changeState;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sortingType = 'Data urodzenia (rosnąco)';

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> sortingOptions = [
      const DropdownMenuItem(
          value: "Data urodzenia (rosnąco)",
          child: Text("Data urodzenia (rosnąco)")),
      const DropdownMenuItem(
          value: "Data urodzenia (malejąco)",
          child: Text("Data urodzenia (malejąco)")),
      const DropdownMenuItem(value: "A-Z", child: Text("A-Z")),
      const DropdownMenuItem(value: "Z-A", child: Text("Z-A")),
    ];

    final List<Patient> patientList = [
      Patient(
          imie: "Jan",
          nazwisko: "Kowalski",
          dataUrodzenia: DateTime.utc(2000, 10, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Adam",
          nazwisko: "Nowak",
          dataUrodzenia: DateTime.utc(2023, 5, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "XYZ",
          nazwisko: "ABC",
          dataUrodzenia: DateTime.utc(2010, 10, 8),
          gender: "K",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Jan",
          nazwisko: "Kowalski",
          dataUrodzenia: DateTime.utc(2000, 10, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Adam",
          nazwisko: "Nowak",
          dataUrodzenia: DateTime.utc(2023, 5, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "XYZ",
          nazwisko: "ABC",
          dataUrodzenia: DateTime.utc(2010, 10, 8),
          gender: "K",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Jan",
          nazwisko: "Kowalski",
          dataUrodzenia: DateTime.utc(2000, 10, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Adam",
          nazwisko: "Nowak",
          dataUrodzenia: DateTime.utc(2023, 5, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "XYZ",
          nazwisko: "ABC",
          dataUrodzenia: DateTime.utc(2010, 10, 8),
          gender: "K",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Jan",
          nazwisko: "Kowalski",
          dataUrodzenia: DateTime.utc(2000, 10, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "Adam",
          nazwisko: "Nowak",
          dataUrodzenia: DateTime.utc(2023, 5, 10),
          gender: "M",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
      Patient(
          imie: "XYZ",
          nazwisko: "ABC",
          dataUrodzenia: DateTime.utc(2010, 10, 8),
          gender: "K",
          showDateOfBirth: false,
          buttonText: "Profil",
          buttonAction: "patientProfile"),
    ];

    return Flexible(
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 40,
                    width: 220,
                    child: TextButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Dodaj nowego pacjenta",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                ),
                const SizedBox(width: 200, height: 40, child: SearchBar()),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
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
              ],
            ),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: patientList.length,
                itemBuilder: (BuildContext context, int index) {
                  return PatientListItem(
                    imie: patientList[index].imie,
                    nazwisko: patientList[index].nazwisko,
                    dataUrodzenia: patientList[index].dataUrodzenia,
                    gender: patientList[index].gender,
                    changeState: widget.changeState,
                    showDateOfBirth: patientList[index].showDateOfBirth,
                    buttonText: patientList[index].buttonText,
                    buttonAction: patientList[index].buttonAction,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
