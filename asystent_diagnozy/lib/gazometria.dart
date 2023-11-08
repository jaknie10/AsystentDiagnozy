import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class Gazometria extends StatefulWidget {
  const Gazometria({Key? key, required this.patientId}) : super(key: key);

  final int patientId;

  @override
  State<Gazometria> createState() => _GazometriaState();
}

class _GazometriaState extends State<Gazometria> {
  final _formKey = GlobalKey<FormState>();

  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/gazometria.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (var item in _items)
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: item['pk'],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj prawidłową wartość';
                    }
                    return null;
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, widget.patientId);
                    },
                    child: const Text("Powrót")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
