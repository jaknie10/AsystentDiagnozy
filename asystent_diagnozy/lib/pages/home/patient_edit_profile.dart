import 'package:asystent_diagnozy/models/patient_model.dart';
import 'package:flutter/material.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class Pacjent {
  int id;
  String imie;
  String nazwisko;
  String dataUrodzenia;
  String gender;
  String? opis;

  Pacjent(this.id, this.imie, this.nazwisko, this.dataUrodzenia, this.gender,
      [this.opis]);
}

class _PatientEditProfileState extends State<PatientEditProfile> {
  final _formKey = GlobalKey<FormState>();

  var items = {};

  var results = {};

  String gender = 'K';

  var nowyPacjent = Pacjent(-1, "", "", "", "", "");

  List<DropdownMenuItem<String>> genderOptions = [
    const DropdownMenuItem(value: "M", child: Text("Mężczyzna")),
    const DropdownMenuItem(value: "K", child: Text("Kobieta")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 80.0, right: 80.0, top: 18.0, bottom: 18.0),
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        "Edytuj dane pacjenta:",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(22, 20, 35, 1.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 20.0),
                                      child: Text(
                                        "Płeć:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 20.0),
                                      child: Text(
                                        "ID pacjenta:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 20.0),
                                      child: Text(
                                        "Imię:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 20.0),
                                      child: Text(
                                        "Nazwisko:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 20.0),
                                      child: Text(
                                        "Data urodzenia:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Text(
                                                  "Mężczyzna",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 40.0),
                                                child: Text(
                                                  widget.patient.id.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  nowyPacjent.imie =
                                                      val.toString();
                                                  debugPrint(nowyPacjent.imie);
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  nowyPacjent.nazwisko =
                                                      val.toString();
                                                  debugPrint(
                                                      nowyPacjent.nazwisko);
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  nowyPacjent.dataUrodzenia =
                                                      val.toString();
                                                  debugPrint(nowyPacjent
                                                      .dataUrodzenia);
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 180,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: const Text(
                                      "Dodatkowe informacje:",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: SizedBox(
                                      width: 600,
                                      height: 100,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        onChanged: (val) {
                                          nowyPacjent.opis = val.toString();
                                          debugPrint(
                                              "opis: ${nowyPacjent.opis}");
                                        },
                                        minLines: null,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, right: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, widget.patient.id);
                              },
                              style: IconButton.styleFrom(
                                highlightColor:
                                    const Color.fromRGBO(0, 84, 210, 1),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: const SizedBox(
                                width: 60,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Zapisz",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, widget.patient.id);
                              },
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: const SizedBox(
                                width: 60,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Anuluj",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
