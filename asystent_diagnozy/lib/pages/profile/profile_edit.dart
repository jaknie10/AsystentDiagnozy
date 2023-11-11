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

class Doctor {
  int numerPWZ;
  String imie;
  String nazwisko;
  String dataUrodzenia;
  String email;
  int? numerPESEL;

  Doctor(this.numerPWZ, this.imie, this.nazwisko, this.dataUrodzenia, this.email, [this.numerPESEL]);
}

class _ProfileEditState extends State<ProfileEdit> {

  final _formKey = GlobalKey<FormState>();

  var items = {};

  var results = {};

  String gender = 'K';

  var doctor =  Doctor(00123456789,"Jan","Kowalski","10-10-2010","jankowalski@gmail.com", 1234567);

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 18.0, top: 18.0),
                      child: Text(
                        "Edytuj dane:",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Numer PESEL:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Numer PWZ:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Imię:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Nazwisko:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Data urodzenia:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Adres email:",
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
                                    Container(
                                      width: 300,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0),
                                      child:  Text("00123456789", style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        ),)
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 40.0),
                                      child:  Text("1234567", style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        ),)
                                    ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 30.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  doctor.imie =
                                                      val.toString();
                                                  debugPrint(doctor.imie);
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
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  doctor.nazwisko =
                                                      val.toString();
                                                  debugPrint(
                                                      doctor.nazwisko);
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
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  doctor.dataUrodzenia =
                                                      val.toString();
                                                  debugPrint(doctor
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
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10.0),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  doctor.email =
                                                      val.toString();
                                                  debugPrint(doctor
                                                      .email);
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
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
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
                          
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 18.0, right: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                              child: SizedBox(
                                width: 120,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Zapisz dane",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: SizedBox(
                                width: 80,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Anuluj",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
