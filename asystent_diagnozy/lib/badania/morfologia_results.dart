import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class MorfologiaAnaliza extends StatefulWidget {
  const MorfologiaAnaliza({
    Key? key,
    required this.results,
  }) : super(key: key);

  final Map results;

  @override
  State<MorfologiaAnaliza> createState() => _MorfologiaAnalizaState();
}

class _MorfologiaAnalizaState extends State<MorfologiaAnaliza> {
  var items = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/morfologia.json');
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
          TextButton(
              onPressed: () {
                Navigator.pop(context, widget.results);
              },
              child: const Text("Powrót")),
          DataTable(
            decoration: const BoxDecoration(color: Colors.white),
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Parametr'),
              ),
              DataColumn(
                label: Text('Jednostka'),
              ),
              DataColumn(
                label: Text('min'),
              ),
              DataColumn(
                label: Text('max'),
              ),
              DataColumn(
                label: Text('flag'),
              ),
            ],
            rows: <DataRow>[
              for (final entry in items.entries)
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(entry.value['short'])),
                    DataCell(Text("${widget.results[entry.key]} ${entry.value['unit']}")),
                    DataCell(Text(entry.value['m_low'].toString())),
                    DataCell(Text(entry.value['m_high'].toString())),
                    DataCell(
                      (widget.results[entry.key] < entry.value['m_low'])
                          ? const Text('za malo')
                          : (widget.results[entry.key] > entry.value['m_high'])
                              ? const Text('za duzo')
                              : const Text('w normie'),
                    )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
