import 'package:asystent_diagnozy/morfologia.dart';
import 'package:flutter/material.dart';

import 'badanie_list_item.dart';
import 'patient_edit_profile.dart';
import 'gazometria.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key, required this.patientId}) : super(key: key);

  final patientId;

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
    return 
      Scaffold(
      body:
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: 
          Padding(
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
                          "Jan",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(" "),
                        Text(
                          "Kowalski",
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
                             Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Text("10-11-2023",
                                        style: const TextStyle(fontSize: 15)),
                                  ),
                            "M" == "M"
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
                                  "23",
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
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientEditProfile(patientId: widget.patientId),
                                ),
                              );
                              debugPrint("Patient id: "+result.toString());
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
                              "Edytuj profil",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            )),
                      ),
                      //tymczasowy powrót
                      SizedBox(
                        height: 40,
                        child: TextButton(
                            onPressed: (){Navigator.pop(context);},
                            style: IconButton.styleFrom(
                              highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              "Powrót",
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
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: 
                        IconButton(
                          onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Morfologia(patientId: widget.patientId),
                                ),
                              );
                              debugPrint("Patient id: "+result.toString());
                            }, 
                          icon: Image( 
                            image: AssetImage('assets/morfologia_logo.png'),),  
                            highlightColor: Colors.transparent,  
                            hoverColor: Colors.transparent,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: SizedBox(
                            width: 150,
                            child: IconButton(
                         onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Gazometria(patientId: widget.patientId),
                                ),
                              );
                              debugPrint("Patient id: "+result.toString());
                            },  
                          icon: Image( 
                            image: AssetImage('assets/gazometria_logo.png'), ),  
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
