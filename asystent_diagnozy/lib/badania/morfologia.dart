import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'morfologia_results.dart';

class Morfologia extends StatefulWidget {
  const Morfologia({super.key, required this.patientId, required this.patientGender});

  final int? patientId;
  final String patientGender;

  @override
  State<Morfologia> createState() => _MorfologiaState();
}

class _MorfologiaState extends State<Morfologia> {
  final _formKey = GlobalKey<FormState>();

  var items = {};

  List<Map<String, dynamic>> results = [];
  var interpretations = <dynamic>{};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/morfologia.json');
    final data = await json.decode(response);
    setState(() {
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();

    String? lowerbound;
    String? upperbound;
    if (widget.patientGender == 'M') {
      lowerbound = 'm_low';
      upperbound = 'm_high';
    } else if (widget.patientGender == 'K') {
      lowerbound = 'w_low';
      upperbound = 'w_high';
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                width: 90,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, widget.patientId);
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
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/badanie_morfologia_logo.svg',
                width: 500,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 500,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text("Wprowadź wartości:",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      for (var entry in items.entries)
                        Container(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                    width: 80,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context).colorScheme.background,
                                    ),
                                    child: Text(entry.value['short'],
                                        style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                                    alignment: Alignment.center),
                              ),
                              SizedBox(
                                width: 200,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
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
                                      //labelText: entry.value['short'],
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Text(
                                          entry.value['unit'],
                                          style: const TextStyle(
                                            color: Color.fromARGB(111, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(minWidth: 0, minHeight: 0),
                                      isDense: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj prawidłową wartość';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    results.add({
                                      'short': entry.value['short'],
                                      'value': double.parse(value!),
                                      'lowerbound': entry.value[lowerbound],
                                      'upperbound': entry.value[upperbound],
                                      'unit': entry.value['unit'],
                                      'result': (double.parse(value) < entry.value[lowerbound])
                                          ? 'lt'
                                          : (double.parse(value) > entry.value[upperbound])
                                              ? 'gt'
                                              : 'eq'
                                    });
                                    if (double.parse(value) < entry.value[lowerbound]) {
                                      interpretations.addAll(entry.value['deficit_int']);
                                    } else if (double.parse(value) > entry.value[upperbound]) {
                                      interpretations.addAll(entry.value['surplus_int']);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                width: 100,
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MorfologiaAnaliza(
                                  patientId: widget.patientId!,
                                  results: results,
                                  interpretations: interpretations),
                            ));
                      }
                    },
                    style: IconButton.styleFrom(
                      highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      "Analizuj",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
