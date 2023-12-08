import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profile_edit.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.doctorId,
  });

  final doctorId;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    const String imie = "Jan";
    const String nazwisko = 'Kowalski';

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: SvgPicture.asset(
                  'assets/lekarz_logo.svg',
                  width: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                child: Text(
                  "Cześć, $imie $nazwisko",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.0, left: 5.0),
                      child: Container(
                        height: 330,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, top: 10.0, bottom: 30.0),
                                    child: Text(
                                      "Statystyki",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Wykonanych badań:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      99, 99, 99, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Najczęściej wykonywane \nbadanie:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      99, 99, 99, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Liczba pacjentów:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      99, 99, 99, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "155",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Morfologia",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "100",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Container(
                          height: 330,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              //podstawowe informacje
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, top: 10.0, bottom: 30.0),
                                    child: Text(
                                      "Podstawowe informacje",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              //dane
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Imię:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Nazwisko:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Data urodzenia:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Jan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Kowalski",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "10-10-2010",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 50.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Numer PWZ:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 50.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "Numer PESEL:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "1234567",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          "00123456789",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 40,
                                  child: TextButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileEdit(doctorId: 1),
                                          ),
                                        );
                                      },
                                      style: IconButton.styleFrom(
                                        highlightColor:
                                            const Color.fromRGBO(0, 84, 210, 1),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: 110,
                                        child: Text(
                                          "Edytuj profil",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      )
                    ],
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
