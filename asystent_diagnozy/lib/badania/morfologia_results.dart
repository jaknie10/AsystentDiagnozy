import 'package:flutter/material.dart';

class MorfologiaAnaliza extends StatefulWidget {
  const MorfologiaAnaliza({
    Key? key,
    required this.results,
    required this.interpretations,
  }) : super(key: key);

  final List results;
  final Set interpretations;

  @override
  State<MorfologiaAnaliza> createState() => _MorfologiaAnalizaState();
}

class _MorfologiaAnalizaState extends State<MorfologiaAnaliza> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, widget.results);
                    },
                    child: const Text("Powrót")),
                DataTable(
                  border:
                      const TableBorder(verticalInside: BorderSide(width: 2, color: Color.fromRGBO(238, 238, 238, 1))),
                  decoration:
                      const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    for (final entry in widget.results)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(entry['short'])),
                          DataCell(Text("${entry['value']} ${entry['unit']}")),
                          DataCell(Text(entry['lowerbound'].toString())),
                          DataCell(Text(entry['upperbound'].toString())),
                          DataCell(Text(entry['result']))
                        ],
                      )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                for (var entry in widget.interpretations)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
