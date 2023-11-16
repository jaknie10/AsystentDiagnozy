import 'package:flutter/material.dart';

class GazometriaAnaliza extends StatefulWidget {
  const GazometriaAnaliza(
      {Key? key,
      required this.results,
      required this.interpretations,
      required this.clasification})
      : super(key: key);

  final Map<String, Map<String, dynamic>> results;
  final String clasification;
  final List interpretations;

  @override
  State<GazometriaAnaliza> createState() => _GazometriaAnalizaState();
}

class _GazometriaAnalizaState extends State<GazometriaAnaliza> {
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
                  border: const TableBorder(
                      verticalInside: BorderSide(
                          width: 2, color: Color.fromRGBO(238, 238, 238, 1))),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    for (final entry in widget.results.entries)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(entry.value['short'])),
                          DataCell(Text(
                              "${entry.value['value']} ${entry.value['unit']}")),
                          DataCell(Text(entry.value['lowerbound'].toString())),
                          DataCell(Text(entry.value['upperbound'].toString())),
                          DataCell(Text(entry.value['result']))
                        ],
                      )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 147, 146, 202)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(widget.clasification),
                    ),
                  ),
                ),
                Wrap(direction: Axis.horizontal, children: [
                  for (var entry in widget.interpretations)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry),
                        ),
                      ),
                    )
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
