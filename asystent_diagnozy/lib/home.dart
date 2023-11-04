import 'package:flutter/material.dart';

import 'patientListItem.dart';

class Patient {

  final String imie;
  final String nazwisko;
  final DateTime dataUrodzenia;
  final String gender;
  final bool showDateOfBirth;
  final String buttonText;
  final String buttonAction;
  
  Patient({required this.imie, required this.nazwisko, required this.dataUrodzenia, required this.gender, required this.showDateOfBirth, required this.buttonText, required this.buttonAction});
}

class HomePage extends StatefulWidget {

  const HomePage({Key? key,required this.changeState}) : super(key: key);

  final changeState;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String sortingType = 'Data urodzenia (rosnąco)';

  @override
  Widget build(BuildContext context) {


  List<DropdownMenuItem<String>> sortingOptions = [
    DropdownMenuItem(child: Text("Data urodzenia (rosnąco)"),value: "Data urodzenia (rosnąco)"),
    DropdownMenuItem(child: Text("Data urodzenia (malejąco)"),value: "Data urodzenia (malejąco)"),
    DropdownMenuItem(child: Text("A-Z"),value: "A-Z"),
    DropdownMenuItem(child: Text("Z-A"),value: "Z-A"),
    
  ];

  final List<Patient> _patientList = [
      Patient(imie: "Jan", nazwisko: "Kowalski", dataUrodzenia:DateTime.utc(2000,10,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "Adam", nazwisko: "Nowak", dataUrodzenia:DateTime.utc(2023,5,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "XYZ", nazwisko: "ABC", dataUrodzenia:DateTime.utc(2010,10,8), gender: "K", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),

      Patient(imie: "Jan", nazwisko: "Kowalski", dataUrodzenia:DateTime.utc(2000,10,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "Adam", nazwisko: "Nowak", dataUrodzenia:DateTime.utc(2023,5,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "XYZ", nazwisko: "ABC", dataUrodzenia:DateTime.utc(2010,10,8), gender: "K", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),

      Patient(imie: "Jan", nazwisko: "Kowalski", dataUrodzenia:DateTime.utc(2000,10,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "Adam", nazwisko: "Nowak", dataUrodzenia:DateTime.utc(2023,5,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "XYZ", nazwisko: "ABC", dataUrodzenia:DateTime.utc(2010,10,8), gender: "K", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),

      Patient(imie: "Jan", nazwisko: "Kowalski", dataUrodzenia:DateTime.utc(2000,10,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "Adam", nazwisko: "Nowak", dataUrodzenia:DateTime.utc(2023,5,10), gender: "M", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
      Patient(imie: "XYZ", nazwisko: "ABC", dataUrodzenia:DateTime.utc(2010,10,8), gender: "K", showDateOfBirth: false, buttonText: "Profil", buttonAction: "patientProfile"),
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
              child: Container(
                height: 40,
                width: 220,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Dodaj nowego pacjenta", style: TextStyle(color: Colors.white, fontSize: 15), ),
                  style: IconButton.styleFrom(
                    highlightColor: Color.fromRGBO(0, 84, 210, 1),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                  )
                ),
              ),
            ),
            Container(
              width: 200,
              height: 40,
              child: SearchBar()),
              Spacer(),
              Align(
              alignment: Alignment.centerRight,
              child:
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
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
              
           ],
        ),
        Flexible(
          child:ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _patientList.length,
            itemBuilder:(BuildContext context, int index) {
              return PatientListItem(imie: _patientList[index].imie, nazwisko: _patientList[index].nazwisko, dataUrodzenia: _patientList[index].dataUrodzenia, gender:_patientList[index].gender, changeState: widget.changeState, showDateOfBirth: _patientList[index].showDateOfBirth, buttonText: _patientList[index].buttonText, buttonAction: _patientList[index].buttonAction,);
            },
          ),
          ),
          ],
      ),),);
  }
}
