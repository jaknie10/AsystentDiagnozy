import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'morfologia_results.dart';

import 'package:flutter/services.dart';

class Morfologia extends StatefulWidget {
  const Morfologia({Key? key, required this.patientId}) : super(key: key);

  final int patientId;

  @override
  State<Morfologia> createState() => _MorfologiaState();
}

class _MorfologiaState extends State<Morfologia> {
  final _formKey = GlobalKey<FormState>();

  var items = {};

  var results = {};

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/morfologia.json');
    final data = await json.decode(response);
    setState(() {
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(
            onPressed: () {
              Navigator.pop(context, widget.patientId);
            },
            // child: const Text("Powrót")),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    for (var item in items.keys)
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: item,
                        ),
                        initialValue: '0',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Podaj prawidłową wartość';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          results[item] = double.parse(value!);
                        },
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
                      builder: (context) => MorfologiaAnaliza(results: results),
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
