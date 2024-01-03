import 'dart:developer';

import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tarczyca extends StatefulWidget {
  const Tarczyca(
      {super.key, required this.patientId, required this.patientGender});

  final int? patientId;
  final String patientGender;

  @override
  State<Tarczyca> createState() => _TarczycaState();
}

class _TarczycaState extends State<Tarczyca> {
  final _formKey = GlobalKey<FormState>();

  var items = {};
  var interprets = {}; // pobrane interpretacje z JSON
  int? selectedTrimester; // null - brak ciąży; 1 - I trymestr itd.

  Map<String, Map<String, dynamic>> results = {};
  var interpretations = []; // wybrane interpretacje dla klasyfikacji
  Map<String, List> diagnoses = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/tarczyca.json');
    final data = await json.decode(response);
    setState(() {
      items = data['norms'];
      interprets = data['int'];
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
                'assets/badanie_tarczyca_logo_long.svg',
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
                      if (widget.patientGender == "K") ...[
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedTrimester =
                                      null; // Ustaw "Brak ciąży" jako wybrane
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedTrimester == null
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary // Kolor po wybraniu
                                    : Theme.of(context)
                                        .colorScheme
                                        .background, // Kolor domyślny
                              ),
                              child: Text('Brak ciąży',
                                  style: TextStyle(
                                      color: selectedTrimester == null
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTrimester = 1;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedTrimester == 1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                                  child: Text('I trymestr',
                                      style: TextStyle(
                                          color: selectedTrimester == 1
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTrimester = 2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedTrimester == 2
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                                  child: Text('II trymestr',
                                      style: TextStyle(
                                          color: selectedTrimester == 2
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTrimester = 3;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedTrimester == 3
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                                  child: Text('III trymestr',
                                      style: TextStyle(
                                          color: selectedTrimester == 3
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
                                    width: 60,
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
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      tarczycaAnaliza();

                                      log(results.toString());

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TestResultsWidget(
                                              patientId: widget.patientId!,
                                              results: results,
                                              diagnoses: diagnoses,
                                              fromDatabase: false,
                                              createdAt: DateTime.now(),
                                              testName: 'Tarczyca',
                                            ),
                                          ));
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+([\,\.])?\d*'))
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
                                              color: Colors.transparent)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      //labelText: entry.value['short'],
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          entry.value['unit'],
                                          style: const TextStyle(
                                            color: Color.fromARGB(111, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 0, minHeight: 0),
                                      isDense: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj prawidłową wartość';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    value = value!.replaceAll(',', '.');
                                    Map<String, dynamic> entryMap = {};
                                    String? lowerbound;
                                    String? upperbound;
                                    if (selectedTrimester == null) {
                                      lowerbound = 'g_low';
                                      upperbound = 'g_high';
                                    } else if (selectedTrimester == 1) {
                                      lowerbound = '1_low';
                                      upperbound = '1_high';
                                    } else if (selectedTrimester == 2) {
                                      lowerbound = '2_low';
                                      upperbound = '2_high';
                                    } else if (selectedTrimester == 3) {
                                      lowerbound = '3_low';
                                      upperbound = '3_high';
                                    }
                                    entryMap['short'] = entry.value['short'];
                                    entryMap['value'] = double.parse(value);
                                    entryMap['lowerbound'] =
                                        entry.value[lowerbound];
                                    entryMap['upperbound'] =
                                        entry.value[upperbound];
                                    entryMap['unit'] = entry.value["unit"];
                                    entryMap['result'] = (double.parse(value) <
                                            entry.value[lowerbound])
                                        ? 'lt'
                                        : (double.parse(value) >
                                                entry.value[upperbound])
                                            ? 'gt'
                                            : 'eq';
                                    results[entryMap['short']] = entryMap;
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

                        tarczycaAnaliza();

                        log(results.toString());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestResultsWidget(
                                patientId: widget.patientId!,
                                results: results,
                                diagnoses: diagnoses,
                                fromDatabase: false,
                                createdAt: DateTime.now(),
                                testName: 'Tarczyca',
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

  void tarczycaAnaliza() {
    var tsh = results["TSH"]?["result"];
    var ft3 = results["fT3"]?["result"];
    var ft4 = results["fT4"]?["result"];

    if (tsh == "eq" && ft3 == "eq" && ft4 == "eq") {
      diagnoses["Podane wyniki są prawidłowe (eutyreoza)"] = ["Objaw"];
    }
    if (tsh == "lt" && ft3 == "gt" && ft4 == "gt") {
      diagnoses["Pierwotna nadczynność tarczycy"] = ["Objaw"];
    }
    if ((tsh == "gt" || tsh == "eq") && ft3 == "gt" && ft4 == "gt") {
      diagnoses["Wtórna nadczynność tarczycy"] = ["Objaw"];
    }
    if (tsh == "lt" && ft3 == "eq" && ft4 == "eq") {
      diagnoses["Subkliniczna nadczynność tarczycy"] = ["Objaw"];
    }
    if (tsh == "lt" && ft3 == "gt" && ft4 == "gt") {
      diagnoses["Podostre zapalenie tarczycy w fazie nadczynności"] = ["Objaw"];
    }
    if (tsh == "lt" && ft3 == "lt" && ft4 == "lt") {
      diagnoses["Przejściowe zapalenie tarczycy w fazie rozwoju"] = ["Objaw"];
    }
    if (tsh == "gt" && ft3 == "lt" && (ft4 == "eq" || ft4 == "lt")) {
      diagnoses["Pierwotna niedoczynność tarczycy"] = ["Objaw"];
    }
    if ((tsh == "lt" || tsh == "eq") &&
        ft3 == "lt" &&
        (ft4 == "eq" || ft4 == "lt")) {
      diagnoses["Wtórna niedoczynność tarczycy"] = ["Objaw"];
    }
    if (tsh == "gt" && ft3 == "eq" && ft4 == "eq") {
      diagnoses["Subkliniczna niedoczynność tarczycy"] = ["Objaw"];
    }
/*
    switch (classification) {
      case "Hipercholesterolemia prosta":
        interpretations = interprets["HCP"];
        break;
    }  */
    //  interpretations = ["Objaw"];
  }
}
