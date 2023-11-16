import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'gazometria_results.dart';

class Gazometria extends StatefulWidget {
  const Gazometria({Key? key, required this.patientId}) : super(key: key);

  final int patientId;

  @override
  State<Gazometria> createState() => _GazometriaState();
}

class _GazometriaState extends State<Gazometria> {
  final _formKey = GlobalKey<FormState>();

  var items = {};
  var interprets = {}; // pobrane interpretacje z JSON

  Map<String, Map<String, dynamic>> results = {};
  var interpretations = []; // wybrane interpretacje dla klasyfikacji
  String classification = "Podane wyniki badania nie są standardowe";

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/gazometria.json');
    final data = await json.decode(response);
    setState(() {
      items = data['norms'];
      interprets = data['int'];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();

    // String? lowerbound;
    // String? upperbound;

    // lowerbound = 'm_low';
    // upperbound = 'm_high';

    // lowerbound = 'w_low';
    // upperbound = 'w_high';

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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
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
                                suffixIconConstraints: const BoxConstraints(
                                    minWidth: 0, minHeight: 0),
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
                              entryMap['lowerbound'] = entry.value["low"];
                              entryMap['upperbound'] = entry.value["high"];
                              entryMap['result'] = (double.parse(value) <
                                      entry.value["low"])
                                  ? 'lt'
                                  : (double.parse(value) > entry.value["high"])
                                      ? 'gt'
                                      : 'eq';
                              results[entryMap['short']] = entryMap;
                              // if (double.parse(value) <
                              //     entry.value["low"]) {
                              //   interpretations
                              //       .addAll(entry.value['deficit_int']);
                              // } else if (double.parse(value) >
                              //     entry.value["high"]) {
                              //   interpretations
                              //       .addAll(entry.value['surplus_int']);
                              // }
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
//logika klasyfikacji i interpretacji
                // (pH | PaCO₂ | HCO₃ - akt) + BE
                //
                var pH = results["pH"]?["result"];
                var PaCO2 = results["PaCO₂"]?["result"];
                var HCO3 = results["HCO₃ - akt"]?["result"];
                var BE = results["BE"]?["result"];

                if (pH == "gt") {
                  if (PaCO2 == "gt") {
                    if (HCO3 == "gt") {
                      classification =
                          "Zasadowica metaboliczna częściowo skompensowana";
                    }
                  } else if (PaCO2 == "eq") {
                    if (HCO3 == "gt") {
                      classification =
                          "Zasadowica metaboliczna nieskompensowana";
                    }
                  } else if (PaCO2 == "lt") {
                    if (HCO3 == "eq") {
                      classification = "Zasadowica oddechowa nieskompensowana";
                    } else if (HCO3 == "lt") {
                      classification =
                          "Zasadowica oddechowa częściowo skompensowana";
                    }
                  }
                } else if (pH == "lt") {
                  if (PaCO2 == "gt") {
                    if (HCO3 == "eq") {
                      classification = "Kwasica oddechowa nieskompensowana";
                    } else if (HCO3 == "gt") {
                      classification =
                          "Kwasica oddechowa częściowo skompensowana";
                    }
                  } else if (PaCO2 == "eq") {
                    if (HCO3 == "lt") {
                      classification = "Kwasica metaboliczna nieskompensowana";
                    }
                  } else if (PaCO2 == "lt") {
                    if (HCO3 == "lt") {
                      classification =
                          "Kwasica metaboliczna częściowo skompensowana";
                    }
                  }
                } else if (pH == "eq") {
                  if (PaCO2 == "gt" && HCO3 == "gt") {
                    //kwasica oddechowa albo zasadowica metaboliczna
                    if (BE == "eq") {
                      // "Jeśli BE jest w normie -> mamy całkowicie skompensowane zaburzenie oddechowe"
                      classification = "Kwasica oddechowa skompensowana";
                    } else if (BE == "gt") {
                      //"Jeśli nie jest -> mamy całkowicie skompensowane zaburzenie metaboliczne" + "Dodatnie BE wskazuje, że ilość zasad przekracza norme (zasadowica metaboliczna)"
                      classification = "Zasadowica metaboliczna skompensowana";
                    }
                  } else if (PaCO2 == "lt" && HCO3 == "lt") {
                    //zasadowica oddechowa albo kwasica metaboliczna
                    if (BE == "eq") {
                      // "Jeśli BE jest w normie -> mamy całkowicie skompensowane zaburzenie oddechowe"
                      classification = "Zasadowica oddechowa skompensowana";
                    } else if (BE == "gt") {
                      //"Jeśli nie jest -> mamy całkowicie skompensowane zaburzenie metaboliczne" + "Dodatnie BE wskazuje, że ilość zasad przekracza norme (zasadowica metaboliczna)"
                      classification = "Kwasica metaboliczna skompensowana";
                    }
                  }

                  // if (results?["pH"]?["value"]?.value >= 7.4)
                }
                switch (classification) {
                  case "Kwasica oddechowa nieskompensowana" ||
                        "Kwasica oddechowa częściowo skompensowana" ||
                        "Kwasica oddechowa skompensowana":
                    interpretations = interprets["KO"];
                    break;
                  case "Zasadowica oddechowa nieskompensowana" ||
                        "Zasadowica oddechowa częściowo skompensowana" ||
                        "Zasadowica oddechowa skompensowana":
                    interpretations = interprets["ZO"];
                    break;
                  case "Kwasica metaboliczna nieskompensowana" ||
                        "Kwasica metaboliczna częściowo skompensowana" ||
                        "Kwasica metaboliczna skompensowana":
                    interpretations = interprets["KO"];
                    break;
                  case "Zasadowica metaboliczna nieskompensowana" ||
                        "Zasadowica metaboliczna częściowo skompensowana" ||
                        "Zasadowica metaboliczna skompensowana":
                    interpretations = interprets["ZO"];
                    break;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GazometriaAnaliza(
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
}
