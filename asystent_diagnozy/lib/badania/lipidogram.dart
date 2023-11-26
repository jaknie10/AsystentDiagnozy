import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'lipidogram_results.dart';

class Lipidogram extends StatefulWidget {
  const Lipidogram({super.key, required this.patientId, required this.patientGender});

  final int patientId;
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
  String classification = "Podane wyniki badania wydają się poprawne";

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/lipidogram.json');
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
          Row(
            children: [
              BackButton(
                onPressed: () {
                  Navigator.pop(context, widget.patientId);
                },
              ),
              Text("patientId: ${widget.patientId}")
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
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
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
                              Map<String, dynamic> entryMap = {};
                              entryMap['short'] = entry.value['short'];
                              entryMap['value'] = double.parse(value!);
                              entryMap['lowerbound'] = entry.value[lowerbound];
                              entryMap['upperbound'] = entry.value[upperbound];
                              entryMap['unit'] = entry.value["unit"];
                              entryMap['result'] = (double.parse(value) < entry.value[lowerbound])
                                  ? 'lt'
                                  : (double.parse(value) > entry.value[upperbound])
                                      ? 'gt'
                                      : 'eq';
                              results[entryMap['short']] = entryMap;
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

                lipidogramAnaliza();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LipidogramAnaliza(
                          results: results,
                          interpretations: interpretations,
                          clasification: classification),
                    ));
              }
            },
            child: const Text('Analizuj'),
          )
        ],
      ),
    );
  }

  void lipidogramAnaliza() {
    var Chol = results["Chol"]?["result"];
    var LDL = results["LDL"]?["result"];
    var HDL = results["HDL"]?["result"];
    var VLDL = results["VLDL"]?["result"];
    var TAG = results["TAG"]?["result"];

    if ((Chol == "gt" || LDL == "gt") &&
        ((HDL == "eq" || HDL == "lt") &&
            (VLDL == "eq" || VLDL == "lt") &&
            (TAG == "eq" || TAG == "lt"))) {
      classification = "Hipercholesterolemia prosta";
    } else if (TAG == "gt" &&
        ((Chol == "eq" || Chol == "lt") &&
            (LDL == "eq" || LDL == "lt") &&
            (HDL == "eq" || HDL == "lt"))) {
      var value = results["TAG"]?["value"]?.value;
      if (value < 400) {
        classification = "Hipertrójglicerydemia łagodna";
      } else if (value >= 400 && value < 885) {
        classification = "Hipertrójglicerydemia umiarkowana";
      } else if (value >= 885) {
        classification = "Hipertrójglicerydemia ciężka";
      }
    } else if ((Chol == "gt" || LDL == "gt") && TAG == "gt" && (HDL == "eq" || HDL == "lt")) {
      classification = "Hiperlipidemia mieszana";
    } else if (HDL == "gt" && TAG == "gt" && VLDL == "gt") {
      classification = "Dyslipidemia aterogenna";
    } else if (Chol != "eq" || LDL != "eq" || HDL != "eq" || VLDL != "eq" || TAG != "eq") {
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
  }
}
