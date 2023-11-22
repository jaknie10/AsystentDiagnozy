import 'package:flutter/material.dart';
import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/patient.dart';

class AddNewPatient extends StatefulWidget {
  const AddNewPatient({super.key});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  final _formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();

  final SQLiteHelper helper = SQLiteHelper();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  Map<String, dynamic> newPatient = {};

  String gender = 'K';

  List<DropdownMenuItem<String>> genderOptions = [
    const DropdownMenuItem(value: "M", child: Text("Mężczyzna")),
    const DropdownMenuItem(value: "K", child: Text("Kobieta")),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 18.0, bottom: 18.0),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      "Wprowadź dane pacjenta:",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView(
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
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Płeć*:",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "ID pacjenta*:",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Imię:",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Nazwisko:",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: DropdownButtonFormField(
                                                hint: const Text('Wybierz płeć'),
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                        borderSide: BorderSide.none),
                                                    filled: true,
                                                    fillColor: Theme.of(context).colorScheme.background),
                                                style: const TextStyle(
                                                    fontSize: 15, color: Color.fromRGBO(22, 20, 35, 1.0)),
                                                items: genderOptions,
                                                validator: (value) => value == null ? "Wybierz płeć" : null,
                                                onChanged: (val) {
                                                  setState(() {
                                                    gender = val!;
                                                    newPatient['gender'] = val;
                                                  });
                                                }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (value) {
                                                newPatient['id'] = int.parse(value!);
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Podaj prawidłowe ID';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Theme.of(context).colorScheme.background,
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.black)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: TextFormField(
                                              onSaved: (value) {
                                                newPatient['name'] = value.toString();
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  // return 'Podaj prawidłowe imię';
                                                  return null;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Theme.of(context).colorScheme.background,
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.black)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: TextFormField(
                                              onSaved: (value) {
                                                newPatient['surname'] = value.toString();
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  // return 'Podaj prawidłowe nazwisko';
                                                  return null;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Theme.of(context).colorScheme.background,
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: const BorderSide(color: Colors.black)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: TextFormField(
                                              controller: dateController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  // return 'Podaj prawidłową datę urodzenia';
                                                  return null;
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.datetime,
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context).colorScheme.background,
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      borderSide: const BorderSide(color: Colors.transparent)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      borderSide: const BorderSide(color: Colors.transparent)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      borderSide: const BorderSide(color: Colors.black)),
                                                  suffixIcon: IconButton(
                                                    icon: const Icon(
                                                      Icons.calendar_month,
                                                    ),
                                                    onPressed: () async {
                                                      var date = await showDatePicker(
                                                        context: context,
                                                        firstDate: DateTime(1900),
                                                        lastDate: DateTime.now(),
                                                        builder: (context, child) {
                                                          return Theme(
                                                            data: Theme.of(context).copyWith(
                                                                datePickerTheme: const DatePickerThemeData(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5))))),
                                                            child: child!,
                                                          );
                                                        },
                                                      );
                                                      if (date != null) {
                                                        dateController.text = DateFormat('dd/MM/yyyy').format(date);
                                                      }
                                                    },
                                                  ),
                                                  hintText: 'dd/mm/rrrr'),
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
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            height: 180,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                    minLines: null,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).colorScheme.background,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(color: Colors.transparent)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "*Wymaga informacje oznaczone gwiazdką:",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                helper.insertUSer(Patient(
                                  id: newPatient['id'],
                                  name: newPatient['name'],
                                  surname: newPatient['surname'],
                                  gender: newPatient['gender'],
                                ));
                                Navigator.pop(context);
                              }
                            },
                            style: IconButton.styleFrom(
                              highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const SizedBox(
                              width: 150,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Dodaj pacjenta",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
                              Navigator.pop(context);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const SizedBox(
                              width: 80,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Anuluj",
                                  style: TextStyle(
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
    );
  }
}
