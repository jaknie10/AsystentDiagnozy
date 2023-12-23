import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:asystent_diagnozy/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'badanie_list_item.dart';
import 'home.dart';
import 'patient_edit_profile.dart';
import '../../badania/morfologia.dart';
import '../../badania/gazometria.dart';
import '../../badania/lipidogram.dart';
import '../../badania/tarczyca.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class Badanie {
  final String typBadania;
  final DateTime dataBadania;
  final int badanieId;

  Badanie(
      {required this.typBadania,
      required this.dataBadania,
      required this.badanieId});
}

class _PatientProfileState extends State<PatientProfile> {
  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  String sortingType = 'Data badania';
  String sortingOrder = 'DESC';

  List<DropdownMenuItem<String>> sortingOptions = [
    const DropdownMenuItem(value: "Data badania", child: Text("Data badania")),
    const DropdownMenuItem(value: "Typ badania", child: Text("Typ badania")),
  ];

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext pagecontext) {
    int age = DateTime.now().difference(widget.patient.birthdate).inDays ~/ 365;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            //tymczasowy powrót
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 40,
                  width: 90,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: IconButton.styleFrom(
                        highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        "Powrót",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              Text(
                                widget.patient.surname,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(" "),
                              Text(
                                widget.patient.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Text(
                                        formatter
                                            .format(widget.patient.birthdate),
                                        style: const TextStyle(fontSize: 18)),
                                  ),
                                  widget.patient.gender == "M"
                                      ? const ImageIcon(
                                          AssetImage('assets/gender_male.png'),
                                        )
                                      : const ImageIcon(
                                          AssetImage(
                                              'assets/gender_female.png'),
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
                            SizedBox(
                              height: 40,
                              child: TextButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PatientEditProfile(
                                                patient: widget.patient),
                                      ),
                                    );
                                    debugPrint("Patient id: $result");
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
                                  child: const Text(
                                    "Edytuj profil",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                height: 40,
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Usuwanie Pacjenta"),
                                                content: Text(
                                                    "Czy na pewno chcesz usunąć pacjenta ${widget.patient.name} ${widget.patient.surname}?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text("ANULUJ")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        helper.deletePatient(
                                                            widget.patient.id!);
                                                        Navigator.of(
                                                                pagecontext)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (pagecontext) =>
                                                                            const HomePage()),
                                                                (Route route) =>
                                                                    false);
                                                      },
                                                      child: const Text(
                                                          "POTWIERDŹ"))
                                                ],
                                              ));
                                    },
                                    style: IconButton.styleFrom(
                                      highlightColor: Colors.red,
                                      backgroundColor:
                                          const Color.fromRGBO(255, 0, 0, 0.7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Usuń profil",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 25.0, bottom: 10.0),
                child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.white),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Opis pacjenta",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 75,
                              child: ListView(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                scrollDirection: Axis.vertical,
                                children: const [
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a mattis risus, et tincidunt sapien. Pellentesque mattis, sem sit amet hendrerit aliquet, mauris turpis hendrerit nisi, id iaculis augue erat eget neque. Integer tempor, nibh quis malesuada semper, justo risus tempus eros, eget fringilla elit augue et arcu. ",
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )))),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 25),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 15.0),
                          child: Text(
                            "Dodaj nowe badanie",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    Container(
                      height: 130,
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(
                            width: 150,
                            child: IconButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Morfologia(
                                        patientId: widget.patient.id,
                                        patientGender: widget.patient.gender),
                                  ),
                                );
                                debugPrint("Patient id: $result");
                              },
                              icon: const Image(
                                image: AssetImage('assets/Morfologia_logo.png'),
                              ),
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              child: IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Lipidogram(
                                          patientId: widget.patient.id,
                                          patientGender: widget.patient.gender),
                                    ),
                                  );
                                  debugPrint("Patient id: $result");
                                },
                                icon: const Image(
                                  image: AssetImage(
                                      'assets/badanie_lipidogram_logo.png'),
                                ),
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              )),
                          SizedBox(
                              width: 150,
                              child: IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Gazometria(
                                          patientId: widget.patient.id),
                                    ),
                                  );
                                  debugPrint("Patient id: $result");
                                },
                                icon: const Image(
                                  image:
                                      AssetImage('assets/Gazometria_logo.png'),
                                ),
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              )),
                          SizedBox(
                              width: 150,
                              child: IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Tarczyca(
                                          patientId: widget.patient.id,
                                          patientGender: widget.patient.gender),
                                    ),
                                  );
                                  debugPrint("Patient id: $result");
                                },
                                icon: const Image(
                                  image: AssetImage(
                                      'assets/badanie_tarczyca_logo.png'),
                                ),
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              )),
                          SizedBox(
                              width: 150,
                              child: IconButton(
                                onPressed: () async {},
                                icon: const Image(
                                  image: AssetImage(
                                      'assets/badanie_uniwersalne_logo.png'),
                                ),
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, top: 10.0, bottom: 10.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (sortingOrder == 'ASC') {
                            sortingOrder = 'DESC';
                          } else {
                            sortingOrder = 'ASC';
                          }
                        });
                      },
                      icon: Icon((sortingOrder == 'ASC')
                          ? Icons.arrow_downward
                          : Icons.arrow_upward),
                      color: const Color.fromRGBO(22, 20, 35, 1.0),
                      highlightColor: Theme.of(context).colorScheme.secondary,
                      hoverColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 25.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0)),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  style: BorderStyle.solid,
                                  width: 4),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              image: AssetImage('assets/badanie_logo.png'),
                            ),
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    style: BorderStyle.solid,
                                    width: 4),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "Typ badania",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ))),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    style: BorderStyle.solid,
                                    width: 4),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "Data badania",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ))),
                      ),
                      Expanded(
                        flex: 8,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                          ),
                          child: Container(
                              height: 60,
                              decoration: const BoxDecoration(),
                              child: const Center()),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 10.0),
              child: FutureBuilder(
                  future: helper.getTestsByPatientId(widget.patient.id!),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return const Center(child: CircularProgressIndicator());
                    // } else
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Brak badań.'));
                    } else {
                      final tests = snapshot.data!;
                      // print(badania.length);
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: tests.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BadanieListItem(
                            badanie: tests[index],
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
