import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'morfologia_results.dart';

class Morfologia extends StatefulWidget {
  const Morfologia({Key? key, required this.patientId, required this.patientGender}) : super(key: key);

  final int patientId;
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
          Row(
            children: [
              BackButton(
                onPressed: () {
                  Navigator.pop(context, widget.patientId);
                },
              ),
              Text("patientId: ${widget.patientId}, gender: ${widget.patientGender}")
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Form(
                key: _formKey,
                child: Wrap(
                  children: [
                    for (var entry in items.entries)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                labelText: entry.value['short'],
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    entry.value['unit'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(111, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
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
                      ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MorfologiaAnaliza(results: results, interpretations: interpretations),
                    ));
              }
            },
            child: const Text('Analizuj'),
          )
        ],
      ),
    );
  }
}
