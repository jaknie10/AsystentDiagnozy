import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mocz extends StatefulWidget {
  const Mocz({super.key, required this.patientId});

  final int? patientId;

  @override
  State<Mocz> createState() => _MoczState();
}

class _MoczState extends State<Mocz> {
  final _formKey = GlobalKey<FormState>();

  var items = {};

  Map<String, dynamic> results = {};
  var interpretations = <dynamic>{};
  Map<String, List> diagnoses = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/mocz.json');
    final data = await json.decode(response);
    setState(() {
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();

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
                    child: const Text(
                      "Powrót",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/badanie_mocz_logo_long.svg',
                width: 500,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 500,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
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
                            child: const Text("Wprowadź wartości:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      for (var entry in items.entries)
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                    width: 140,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(entry.value['short'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal))),
                              ),
                              SizedBox(
                                width: 200,
                                child: () {
                                  if (entry.value['low'] != null) {
                                    return TextFormField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\,|\.?\d*'))
                                      ],
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            entry.value['unit'],
                                            style: const TextStyle(
                                              color:
                                                  Color.fromARGB(111, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                                minWidth: 0, minHeight: 0),
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Podaj prawidłową wartość';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        value = value!.replaceAll(',', '.');
                                        results['${entry.value['short']}'] = {
                                          'short': entry.value['short'],
                                          'value': double.parse(value),
                                          'lowerbound': entry.value["low"],
                                          'upperbound': entry.value["high"],
                                          'unit': entry.value['unit'],
                                          'result': (double.parse(value) <
                                                  entry.value["low"])
                                              ? 'lt'
                                              : (double.parse(value) >
                                                      entry.value["high"])
                                                  ? 'gt'
                                                  : 'eq',
                                        };
                                        if (double.parse(value) <
                                            entry.value["low"]) {
                                          interpretations.addAll(
                                              entry.value['deficit_int']);
                                        } else if (double.parse(value) >
                                            entry.value["high"]) {
                                          interpretations.addAll(
                                              entry.value['surplus_int']);
                                        }
                                      },
                                    );
                                  } else {
                                    List<String> allOptions = [];
                                    if (entry.value['good'] != null) {
                                      allOptions.addAll(
                                          entry.value['good'].cast<String>());
                                    }
                                    if (entry.value['bad'] != null) {
                                      allOptions.addAll(
                                          entry.value['bad'].cast<String>());
                                    }

                                    String? selectedOption;

                                    return DropdownButtonFormField<String>(
                                      value: selectedOption,
                                      items: allOptions.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        selectedOption = newValue;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Wybierz',
                                        // Inne właściwości dekoracji
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Podaj prawidłową wartość';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        var falsePositiveBy =
                                            entry.value['false_positive_by'];
                                        bool potentialFalsePositive = false;
                                        var correspondingEntry;

                                        if (falsePositiveBy != null) {
                                          correspondingEntry = results.entries
                                              .firstWhere((e) =>
                                                  e.value['short'] ==
                                                  falsePositiveBy);
                                        }

                                        if (correspondingEntry != null &&
                                            //correspondingEntry.value != null &&
                                            correspondingEntry
                                                    .value['result'] ==
                                                'bd') {
                                          potentialFalsePositive = true;
                                        }

                                        String resultValue = (value ==
                                                entry.value["good"][0])
                                            ? 'gd'
                                            : (value !=
                                                        entry.value["good"]
                                                            [0] &&
                                                    potentialFalsePositive ==
                                                        false)
                                                ? 'bd'
                                                : 'fp';

                                        results['${entry.value['short']}'] = {
                                          'short': entry.value['short'],
                                          'value': value,
                                          'good': entry.value["good"],
                                          'bad': entry.value["bad"],
                                          'unit': entry.value['unit'],
                                          'result': resultValue,
                                        };

                                        if (resultValue == 'bd') {
                                          int index =
                                              entry.value["bad"].indexOf(value);
                                          if (index != -1 &&
                                              index <
                                                  entry.value["bad_int"]
                                                      .length) {
                                            var foundInterpretations =
                                                entry.value["bad_int"][index];
                                            interpretations
                                                .addAll(foundInterpretations);
                                            // dodać warunek na false-positive
                                          }
                                        }
                                        if (resultValue == 'fp' &&
                                            entry.value['short'] == "ketony") {
                                          interpretations.add(
                                              "Przy niewłaściwej bilirubinie objawy ketonów nie są brane pod uwagę (false positive)");
                                        }
                                        if (resultValue == 'fp' &&
                                            entry.value['short'] ==
                                                "urobilinogen") {
                                          interpretations.add(
                                              "Przy niewłaściwej bilirubinie objawy urobilinogenu nie są brane pod uwagę (false positive)");
                                        }
                                      },
                                    );
                                  }
                                }(),
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
                        diagnoses["general"] = interpretations.toList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestResultsWidget(
                                patientId: widget.patientId!,
                                results: results,
                                diagnoses: diagnoses,
                                fromDatabase: false,
                                createdAt: DateTime.now(),
                                testName: 'Mocz',
                              ),
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
                    child: const Text(
                      "Analizuj",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
