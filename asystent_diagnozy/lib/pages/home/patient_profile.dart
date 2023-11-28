import 'package:flutter/material.dart';

import 'badanie_list_item.dart';
import 'patient_edit_profile.dart';
import '../../badania/morfologia.dart';
import '../../badania/gazometria.dart';
import '../../badania/lipidogram.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile(
      {Key? key, required this.patientId, required this.patientGender})
      : super(key: key);

  final int patientId;
  final String patientGender;

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

  List<Badanie> badanieList = [
    Badanie(
      typBadania: "Morfologia",
      dataBadania: DateTime(2023, 11, 09),
      badanieId: 1,
    ),
    Badanie(
      typBadania: "Gazometria",
      dataBadania: DateTime(2020, 11, 09),
      badanieId: 2,
    ),
    Badanie(
      typBadania: "Lipidogram",
      dataBadania: DateTime(2023, 11, 09),
      badanieId: 3,
    ),
    Badanie(
      typBadania: "Morfologia",
      dataBadania: DateTime(2025, 11, 09),
      badanieId: 4,
    ),
    Badanie(
      typBadania: "Morfologia",
      dataBadania: DateTime(2027, 11, 09),
      badanieId: 5,
    ),
    Badanie(
      typBadania: "Morfologia",
      dataBadania: DateTime(2025, 11, 09),
      badanieId: 6,
    ),
    Badanie(
      typBadania: "Lipidogram",
      dataBadania: DateTime(2027, 11, 09),
      badanieId: 7,
    ),
    Badanie(
      typBadania: "Gazometria",
      dataBadania: DateTime(2025, 11, 09),
      badanieId: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  width: 100,
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
                      child: Text(
                        "Powrót",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
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
                                "Kowalski",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(" "),
                              Text(
                                "Jan",
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
                                    child: Text("10-11-2023",
                                        style: const TextStyle(fontSize: 18)),
                                  ),
                                  "M" == "M"
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
                                        "23",
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
                                                patientId: widget.patientId),
                                      ),
                                    );
                                    debugPrint(
                                        "Patient id: " + result.toString());
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
                                  child: Text(
                                    "Edytuj profil",
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
                            Text(
                              "Opis pacjenta:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 75,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                scrollDirection: Axis.vertical,
                                children: [
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
                height: 160,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                            top: 10.0,
                          ),
                          child: Text(
                            "Dodaj nowe badanie",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    Container(
                      height: 120,
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Morfologia(
                                          patientId: widget.patientId,
                                          patientGender: widget.patientGender),
                                    ),
                                  );
                                  debugPrint(
                                      "Patient id: " + result.toString());
                                },
                                icon: Image(
                                  image:
                                      AssetImage('assets/Morfologia_logo.png'),
                                ),
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              )),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: SizedBox(
                                width: 150,
                                child: IconButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Gazometria(
                                            patientId: widget.patientId),
                                      ),
                                    );
                                    debugPrint(
                                        "Patient id: " + result.toString());
                                  },
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/Gazometria_logo.png'),
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: SizedBox(
                                width: 150,
                                child: IconButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Lipidogram(
                                            patientId: widget.patientId,
                                            patientGender:
                                                widget.patientGender),
                                      ),
                                    );
                                    debugPrint(
                                        "Patient id: " + result.toString());
                                  },
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/lipidogram_logo.png'),
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: SizedBox(
                                width: 150,
                                child: IconButton(
                                  onPressed: () async {
                                  
                                  },
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/badanie_uniwersalne_logo.png'),
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: SizedBox(
                                width: 150,
                                child: IconButton(
                                  onPressed: () async {
                                   
                                  },
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/badanie_uniwersalne_logo.png'),
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                )),
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
                padding:
                    const EdgeInsets.only(right: 25.0, top: 10.0, bottom: 10.0),
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
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 25.0, top: 4.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
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
                            icon: Image(
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
                            child: Center(
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
                            child: Center(
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                          ),
                          child: Container(
                              height: 60,
                              decoration: BoxDecoration(),
                              child: Center()),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: badanieList.length,
                itemBuilder: (BuildContext context, int index) {
                  return BadanieListItem(
                    typBadania: badanieList[index].typBadania,
                    dataBadania: badanieList[index].dataBadania,
                    badanieId: badanieList[index].badanieId,
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
