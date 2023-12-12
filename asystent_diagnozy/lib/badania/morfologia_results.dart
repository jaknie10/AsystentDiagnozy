import 'package:flutter/material.dart';

import '../database/database_service.dart';
import '../models/test_result_model.dart';
import '../pages/home/home.dart';

class MorfologiaAnaliza extends StatefulWidget {
  const MorfologiaAnaliza({
    super.key,
    required this.patientId,
    required this.results,
    required this.interpretations,
  });

  final List results;
  final Set interpretations;
  final int patientId;

  @override
  State<MorfologiaAnaliza> createState() => _MorfologiaAnalizaState();
}

class _MorfologiaAnalizaState extends State<MorfologiaAnaliza> {
  final SQLiteHelper helper = SQLiteHelper();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
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
                          verticalInside:
                              BorderSide(width: 2, color: Color.fromRGBO(238, 238, 238, 1))),
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      columns: <DataColumn>[
                        for (final name in ['Parametr', 'Jednostka', 'Min', 'Max', 'Flag'])
                          DataColumn(
                            label: Text(name),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      direction: Axis.horizontal,
                      children: [
                        for (var entry in widget.interpretations)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.fromBorderSide(
                                      BorderSide(color: Theme.of(context).primaryColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(entry),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextButton(
                    onPressed: () {
                      //zapisanie wyniku do bazy danych
                      helper.insertTestResult(TestResult(
                          patientId: widget.patientId,
                          testType: 'Morfologia',
                          createdAt: DateTime.now(),
                          results: {
                            "results": widget.results,
                            "interpretations": widget.interpretations.toList(),
                          }));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (Route route) => false);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const SizedBox(
                      width: 110,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Zapisz wynik",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
