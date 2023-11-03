import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class Morfologia extends StatefulWidget {
  const Morfologia({Key? key}) : super(key: key);

  @override
  State<Morfologia> createState() => _MorfologiaState();
}

class _MorfologiaState extends State<Morfologia> {
  final _formKey = GlobalKey<FormState>();

  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/db.json');
    final data = await json.decode(response);
    setState(() {
      _items = data['morfologia'];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Flexible(
      child: Container(
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
                child: const Text('Analizuj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
