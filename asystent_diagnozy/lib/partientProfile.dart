import 'package:flutter/material.dart';

import 'patientListItem.dart';
import 'badanieListItem.dart';

class PatientProfile extends StatefulWidget {

  const PatientProfile({Key? key,required this.changeState}) : super(key: key);
  
  final changeState;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {

  int age = DateTime.now().difference(DateTime(2000,10,10,00,01)).inDays ~/365;

  String sortingType = 'Data badania (rosnąco)';

  List<DropdownMenuItem<String>> sortingOptions = [
    DropdownMenuItem(child: Text("Data badania (rosnąco)"),value: "Data badania (rosnąco)"),
    DropdownMenuItem(child: Text("Data badania (malejąco)"),value: "Data badania (malejąco)"),
    DropdownMenuItem(child: Text("A-Z"),value: "A-Z"),
    DropdownMenuItem(child: Text("Z-A"),value: "Z-A"),
    
  ];

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: PatientListItem(imie: "Jan", nazwisko: "Kowalski", dataUrodzenia: DateTime(2000,10,10), gender: "M", changeState: widget.changeState, showDateOfBirth: true, buttonText: "Edytuj Profil", buttonAction: "patientEditProfile"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0),
              child: Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white),
                child:
                Column(
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                      child: Text("Dodaj nowe badanie", style: TextStyle(fontSize: 18),),
                    )),
                    Container(
                      height: 110,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: 
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:5.0),
                            child: Container(width: 150 , child: Image(image: AssetImage('assets/morfologia_logo.png'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:5.0),
                            child: Container(width: 150 , child: Image(image: AssetImage('assets/elektroforeza_logo.png'))),
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
                padding: const EdgeInsets.all( 10.0),
                child:
                DecoratedBox(
                  decoration: BoxDecoration( 
                    color:Colors.white, 
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DropdownButtonHideUnderline(
                      child: 
                      DropdownButton(
                          dropdownColor: Colors.white,
                          style: TextStyle(fontSize: 15, color: Color.fromRGBO(22, 20, 35, 1.0)),
                          elevation: 0,
                          value: sortingType,
                          items: sortingOptions,
                          onChanged: (val) {
                            setState(() {
                              sortingType = val.toString();
                            });
                            debugPrint('$sortingType');}
                        ),
                        ),
                  ),
                      ),
                  ),
            ),
            BadanieListItem(),
          ],
      ),
    );
  }
}
