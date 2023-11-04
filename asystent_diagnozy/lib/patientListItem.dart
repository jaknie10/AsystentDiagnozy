import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PatientListItem extends StatefulWidget {

  PatientListItem({
      Key? key,
      required this.imie,
      required this.nazwisko,
      required this.dataUrodzenia,
      required this.gender,
      required this.changeState,
      required this.showDateOfBirth,
      required this.buttonText,
      required this.buttonAction,
    }) : super(key : key);

  final String imie;
  final String nazwisko;
  final DateTime dataUrodzenia;
  final String gender;
  final changeState;
  final bool showDateOfBirth;
  final String buttonText;
  final String buttonAction;
  

  @override
  State<PatientListItem> createState() => _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  
  @override
  Widget build(BuildContext context) {

    int age = DateTime.now().difference(widget.dataUrodzenia).inDays ~/365;

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white),
        child:  Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(widget.imie,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(" "),
                    Text(widget.nazwisko,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25.0),
                    child: Row(children: [
                        widget.showDateOfBirth ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal:40.0),
                          child: Text(widget.dataUrodzenia.toString().substring(0,10),style: TextStyle(fontSize: 15)),
                        ) : Text(""),

                        widget.gender == "M" ? ImageIcon(
                      AssetImage('assets/gender_male.png'),
                      ) : ImageIcon(
                          AssetImage('assets/gender_female.png'),
                      ),
                      Container(
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(age.toString(),style: TextStyle(fontSize: 15),),
                        ),
                      )
                      ], 
                      ),
                  ),
                  Container(
                  height: 40,
                  child: TextButton(
                    onPressed: () { widget.changeState(widget.buttonAction); },
                    child: Text(widget.buttonText, style: TextStyle(color: Colors.white, fontSize: 15), ),
                    style: IconButton.styleFrom(
                      highlightColor: Color.fromRGBO(0, 84, 210, 1),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                    )
                  ),
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
