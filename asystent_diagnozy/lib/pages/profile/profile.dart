import 'package:asystent_diagnozy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asystent_diagnozy/database/database_service.dart';

import 'profile_edit.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SvgPicture.asset(
                  'assets/lekarz_logo.svg',
                  width: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                child: Text(
                  "Cześć, ${widget.user.name} ${widget.user.surname}",
                  style: const TextStyle(
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
                      padding: const EdgeInsets.only(right: 15.0, left: 5.0),
                      child: Container(
                        height: 330,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Align(
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
                                  const Column(
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
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: FutureBuilder(
                                            future:
                                                helper.getDoctorStatistics(),
                                            builder: (context, snapshot) {
                                              // if (snapshot.connectionState == ConnectionState.waiting) {
                                              //   return const Center(child: CircularProgressIndicator());
                                              // } else
                                              if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Center(
                                                    child: Text('Brak badań.'));
                                              } else {
                                                final tests = snapshot.data!;
                                                return Text(
                                                  tests[0][0]
                                                      .values
                                                      .first
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                );
                                              }
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: FutureBuilder(
                                            future:
                                                helper.getDoctorStatistics(),
                                            builder: (context, snapshot) {
                                              // if (snapshot.connectionState == ConnectionState.waiting) {
                                              //   return const Center(child: CircularProgressIndicator());
                                              // } else
                                              if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Center(
                                                    child: Text('Brak badań.'));
                                              } else {
                                                final tests = snapshot.data!;
                                                var badanie =
                                                    tests[1][0].values.first;

                                                return badanie == null
                                                    ? const Text(
                                                        "brak",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      )
                                                    : Text(
                                                        badanie.toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      );
                                              }
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: FutureBuilder(
                                            future:
                                                helper.getDoctorStatistics(),
                                            builder: (context, snapshot) {
                                              // if (snapshot.connectionState == ConnectionState.waiting) {
                                              //   return const Center(child: CircularProgressIndicator());
                                              // } else
                                              if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Center(
                                                    child: Text('Brak badań.'));
                                              } else {
                                                final tests = snapshot.data!;
                                                return Text(
                                                  tests[2][0]
                                                      .values
                                                      .first
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                );
                                              }
                                            }),
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
                        padding: const EdgeInsets.only(right: 15.0),
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
                              const Align(
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
                                  const Column(
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
                                          "Login:",
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
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          widget.user.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          widget.user.surname,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Text(
                                          widget.user.login,
                                          style: const TextStyle(
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
                                                const ProfileEdit(doctorId: 1),
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
                                      child: const SizedBox(
                                        width: 110,
                                        child: Text(
                                          "Edytuj profil",
                                          style: TextStyle(
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
