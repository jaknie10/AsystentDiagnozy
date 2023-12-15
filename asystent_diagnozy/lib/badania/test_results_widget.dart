import '../database/database_service.dart';
import '../models/test_result_model.dart';
import 'package:asystent_diagnozy/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestResultsWidget extends StatefulWidget {
  const TestResultsWidget(
      {super.key,
      required this.patientId,
      required this.testName,
      required this.results,
      required this.interpretations,
      this.classification});

  final Map<dynamic, dynamic> results;
  final String? classification;
  final List interpretations;
  final int patientId;
  final String testName;

  @override
  State<TestResultsWidget> createState() => _TestResultsWidgetState();
}

class _TestResultsWidgetState extends State<TestResultsWidget> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //przycisk Powrót
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                width: 90,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, widget.results);
                    },
                    style: IconButton.styleFrom(
                      highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text(
                      "Powrót",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            ),
          ),
          //logo
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
              child: SvgPicture.asset(
                'assets/badanie_${widget.testName.toLowerCase()}_logo_long.svg',
                width: 450,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          //wyniki analizy
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                              ),
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Theme.of(context).colorScheme.background,
                                            style: BorderStyle.solid,
                                            width: 4),
                                      ),
                                      color: Colors.white),
                                  child: const Center(
                                      child: Text(
                                    "Parametr",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ))),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Theme.of(context).colorScheme.background,
                                          style: BorderStyle.solid,
                                          width: 4),
                                    ),
                                    color: Colors.white),
                                child: const Center(
                                    child: Text(
                                  "Wartość",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ))),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Theme.of(context).colorScheme.background,
                                          style: BorderStyle.solid,
                                          width: 4),
                                    ),
                                    color: Colors.white),
                                child: const Center(
                                    child: Text(
                                  "Minimalna wartość referencyjna",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ))),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Theme.of(context).colorScheme.background,
                                          style: BorderStyle.solid,
                                          width: 4),
                                    ),
                                    color: Colors.white),
                                child: const Center(
                                    child: Text(
                                  "Maksymalna wartość referencyjna",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ))),
                          ),
                          Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                ),
                                child: Container(
                                    height: 70,
                                    decoration: const BoxDecoration(
                                        // border: Border(
                                        //   right: BorderSide(color: Theme.of(context).colorScheme.background, style: BorderStyle.solid, width: 4),
                                        // ),
                                        color: Colors.white),
                                    child: const Center(
                                        child: Text(
                                      "Flaga",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                              )),
                        ],
                      ),
                      for (final entry in widget.results.entries)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Theme.of(context).colorScheme.background,
                                            style: BorderStyle.solid,
                                            width: 4),
                                      ),
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                    entry.value['short'],
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Theme.of(context).colorScheme.background,
                                            style: BorderStyle.solid,
                                            width: 4),
                                      ),
                                      color: Colors.white),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 2.0),
                                        child: Text(
                                          "${entry.value['value']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "${entry.value['unit']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Theme.of(context).colorScheme.background,
                                            style: BorderStyle.solid,
                                            width: 4),
                                      ),
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                    entry.value['lowerbound'].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 15),
                                  ))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Theme.of(context).colorScheme.background,
                                            style: BorderStyle.solid,
                                            width: 4),
                                      ),
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                    entry.value['upperbound'].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 15),
                                  ))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: (entry.value['result'] == 'gt' ||
                                              entry.value['result'] == 'lt')
                                          ? const Color.fromRGBO(255, 185, 185, 1.0)
                                          : const Color.fromRGBO(168, 255, 191, 1.0)),
                                  child: Center(
                                      child: (entry.value['result'] == 'gt')
                                          ? const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                              size: 30,
                                            )
                                          : (entry.value['result'] == 'eq')
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 30,
                                                )
                                              : const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))),
                            )
                          ]),
                        )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.classification != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(191, 232, 255, 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(widget.classification!,
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            )),
                          ),
                        ),
                      Wrap(
                        children: [
                          for (var entry in widget.interpretations)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(entry, textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
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
                          testType: widget.testName,
                          createdAt: DateTime.now(),
                          results: {
                            "results": widget.results,
                            "interpretations": widget.interpretations,
                            "classification": widget.classification
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
