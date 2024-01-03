import 'dart:developer';

import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Lipidogram extends StatefulWidget {
  const Lipidogram(
      {super.key, required this.patientId, required this.patientGender});

  final int? patientId;
  final String patientGender;

  @override
  State<Lipidogram> createState() => _LipidogramState();
}

class _LipidogramState extends State<Lipidogram> {
  final _formKey = GlobalKey<FormState>();

  var items = {};
  var interprets = {}; // pobrane interpretacje z JSON

  Map<String, Map<String, dynamic>> results = {};
  var interpretations = []; // wybrane interpretacje dla klasyfikacji
  String classification = "Podane wyniki są prawidłowe";
  Map<String, List> diagnoses = {};

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/lipidogram.json');
    final data = await json.decode(response);
    setState(() {
      items = data['norms'];
      interprets = data['int'];
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
                'assets/badanie_lipidogram_logo_long.svg',
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

                                      lipidogramAnaliza();

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
                                              testName: 'Lipidogram',
                                              createdAt: DateTime.now(),
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

                        lipidogramAnaliza();

                        log(results.toString());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestResultsWidget(
                                patientId: widget.patientId!,
                                results: results,
                                diagnoses: diagnoses,
                                fromDatabase: false,
                                testName: 'Lipidogram',
                                createdAt: DateTime.now(),
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

  void lipidogramAnaliza() {
    var chol = results["Chol"]?["result"];
    var ldl = results["LDL"]?["result"];
    var hdl = results["HDL"]?["result"];
    var vldl = results["VLDL"]?["result"];
    var tag = results["TAG"]?["result"];

    if ((chol == "gt" || ldl == "gt") &&
        ((hdl == "eq" || hdl == "lt") &&
            (vldl == "eq" || vldl == "lt") &&
            (tag == "eq" || tag == "lt"))) {
      classification = "Hipercholesterolemia prosta";
    } else if (tag == "gt" &&
        ((chol == "eq" || chol == "lt") &&
            (ldl == "eq" || ldl == "lt") &&
            (hdl == "eq" || hdl == "lt"))) {
      var value = results["TAG"]?["value"];
      if (value < 400) {
        classification = "Hipertrójglicerydemia łagodna";
      } else if (value >= 400 && value < 885) {
        classification = "Hipertrójglicerydemia umiarkowana";
      } else if (value >= 885) {
        classification = "Hipertrójglicerydemia ciężka";
      }
    } else if ((chol == "gt" || ldl == "gt") &&
        tag == "gt" &&
        (hdl == "eq" || hdl == "lt")) {
      classification = "Hiperlipidemia mieszana";
    } else if (hdl == "gt" && tag == "gt" && vldl == "gt") {
      classification = "Dyslipidemia aterogenna";
    } else if (chol != "eq" ||
        ldl != "eq" ||
        hdl != "eq" ||
        vldl != "eq" ||
        tag != "eq") {
      classification = "Podane wyniki nie są standardowe";
    }

    switch (classification) {
      case "Hipercholesterolemia prosta":
        interpretations = interprets["HCP"];
        break;
      case "Hipertrójglicerydemia łagodna" ||
            "Hipertrójglicerydemia umiarkowana" ||
            "Hipertrójglicerydemia ciężka":
        interpretations = interprets["HT"];
        break;
      case "Hiperlipidemia mieszana":
        interpretations = interprets["HLM"];
        break;
      case "Dyslipidemia aterogenna":
        interpretations = interprets["DLA"];
        break;
    }
    diagnoses[classification] = interpretations;
  }
}
