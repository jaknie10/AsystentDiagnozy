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
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, widget.results);
            },
            child: const Text("Powrót")),
        Container(
          color: Theme.of(context).colorScheme.background,
          child: DataTable(
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
              for (var item in items.values)
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(item['pk'])),
                    DataCell(
                        Text("${widget.results[item['pk']]} ${item['unit']}")),
                    DataCell(Text(item['m_low'].toString())),
                    DataCell(Text(item['m_high'].toString())),
                    DataCell(
                      (widget.results[item['pk']] < item['m_low'])
                          ? const Text('za malo')
                          : (widget.results[item['pk']] > item['m_low'])
                              ? const Text('za duzo')
                              : const Text('w normie'),
                    )
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
