import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Gazometria extends StatefulWidget {
  const Gazometria({super.key, required this.patientId});

  final int? patientId;

  @override
  State<Gazometria> createState() => _GazometriaState();
}

class _GazometriaState extends State<Gazometria> {
  final _formKey = GlobalKey<FormState>();

  var items = {};
  var interprets = {}; // pobrane interpretacje z JSON

  Map<String, Map<String, dynamic>> results = {};
  var interpretations = []; // wybrane interpretacje dla klasyfikacji
  String classification = "Podane wyniki badania wydają się poprawne";

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
                'assets/badanie_gazometria_logo_long.svg',
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
                            child: Text("Wprowadź wartości:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                    width: 120,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: Text(entry.value['short'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal)),
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
                                    Map<String, dynamic> entryMap = {};
                                    entryMap['short'] = entry.value['short'];
                                    entryMap['value'] = double.parse(value!);
                                    entryMap['lowerbound'] = entry.value["low"];
                                    entryMap['upperbound'] =
                                        entry.value["high"];
                                    entryMap['unit'] = entry.value["unit"];
                                    entryMap['result'] = (double.parse(value) <
                                            entry.value["low"])
                                        ? 'lt'
                                        : (double.parse(value) >
                                                entry.value["high"])
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

                        gazometriaAnaliza();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestResultsWidget(
                                  patientId: widget.patientId!,
                                  results: results,
                                  interpretations: interpretations,
                                  classification: classification,
                                  fromDatabase: false,
                                  testName: 'Gazometria'),
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

  void gazometriaAnaliza() {
    //logika klasyfikacji i interpretacji
    // (pH | PaCO₂ | HCO₃ - akt) + BE

    var pH = results["pH"]?["result"];
    var paCO2 = results["PaCO₂"]?["result"];
    var hCO3 = results["HCO₃ - akt"]?["result"];
    var bE = results["BE"]?["result"];

    if (pH == "gt") {
      if (paCO2 == "gt") {
        if (hCO3 == "gt") {
          classification = "Zasadowica metaboliczna częściowo skompensowana";
        }
      } else if (paCO2 == "eq") {
        if (hCO3 == "gt") {
          classification = "Zasadowica metaboliczna nieskompensowana";
        }
      } else if (paCO2 == "lt") {
        if (hCO3 == "eq") {
          classification = "Zasadowica oddechowa nieskompensowana";
        } else if (hCO3 == "lt") {
          classification = "Zasadowica oddechowa częściowo skompensowana";
        }
      }
    } else if (pH == "lt") {
      if (paCO2 == "gt") {
        if (hCO3 == "eq") {
          classification = "Kwasica oddechowa nieskompensowana";
        } else if (hCO3 == "gt") {
          classification = "Kwasica oddechowa częściowo skompensowana";
        }
      } else if (paCO2 == "eq") {
        if (hCO3 == "lt") {
          classification = "Kwasica metaboliczna nieskompensowana";
        }
      } else if (paCO2 == "lt") {
        if (hCO3 == "lt") {
          classification = "Kwasica metaboliczna częściowo skompensowana";
        }
      }
    } else if (pH == "eq") {
      if (paCO2 == "gt" && hCO3 == "gt") {
        //kwasica oddechowa albo zasadowica metaboliczna
        if (bE == "eq" || bE == "lt") {
          // "Jeśli BE jest w normie -> mamy całkowicie skompensowane zaburzenie oddechowe"
          classification = "Kwasica oddechowa skompensowana";
        } else if (bE == "gt") {
          //"Jeśli nie jest -> mamy całkowicie skompensowane zaburzenie metaboliczne" + "Dodatnie BE wskazuje, że ilość zasad przekracza norme (zasadowica metaboliczna)"
          classification = "Zasadowica metaboliczna skompensowana";
        }
      } else if (paCO2 == "lt" && hCO3 == "lt") {
        //zasadowica oddechowa albo kwasica metaboliczna
        if (bE == "eq" || bE == "lt") {
          // "Jeśli BE jest w normie -> mamy całkowicie skompensowane zaburzenie oddechowe"
          classification = "Zasadowica oddechowa skompensowana";
        } else if (bE == "gt") {
          //"Jeśli nie jest -> mamy całkowicie skompensowane zaburzenie metaboliczne" + "Dodatnie BE wskazuje, że ilość zasad przekracza norme (zasadowica metaboliczna)"
          classification = "Kwasica metaboliczna skompensowana";
        }
      } else if (pH != "eq" ||
          paCO2 != "eq" ||
          hCO3 != "eq" ||
          bE != "eq" ||
          results["HCO3std"]?["result"] != "eq" ||
          results["PaO2"]?["result"] != "eq" ||
          results["ctCO2"]?["result"] != "eq" ||
          results["SaO2"]?["result"] != "eq") {
        classification = "Podane wyniki nie są standardowe";
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
  }
}
