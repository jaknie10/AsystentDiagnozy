import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'gazometria_results.dart';

import 'package:flutter/services.dart';

class Gazometria extends StatefulWidget {
  const Gazometria({Key? key, required this.patientId}) : super(key: key);

  final int patientId;

  @override
  State<Gazometria> createState() => _GazometriaState();
}

class _GazometriaState extends State<Gazometria> {
  final _formKey = GlobalKey<FormState>();

  var items = {};

  var results = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/gazometria.json');
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
          BackButton(
            onPressed: () {
              Navigator.pop(context, widget.patientId);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Form(
                key: _formKey,
                child: Column(
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

                            // initialValue: '0',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Podaj prawidłową wartość';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              results[entry.key] = double.parse(value!);
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
                      builder: (context) => GazometriaAnaliza(results: results),
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
