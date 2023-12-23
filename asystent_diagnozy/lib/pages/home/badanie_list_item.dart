import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:asystent_diagnozy/models/test_result_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BadanieListItem extends StatefulWidget {
  const BadanieListItem({
    super.key,
    required this.badanie,
  });

  final TestResult badanie;

  @override
  State<BadanieListItem> createState() => _BadanieListItemState();
}

class _BadanieListItemState extends State<BadanieListItem> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 4.0),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(color: Colors.white),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestResultsWidget(
                          patientId: widget.badanie.patientId,
                          results: widget.badanie.results["results"],
                          diagnoses: widget.badanie.results["diagnoses"],
                          fromDatabase: true,
                          createdAt: widget.badanie.createdAt.toString(),
                          testName: widget.badanie.testType)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color: Theme.of(context).colorScheme.background,
                              style: BorderStyle.solid,
                              width: 4),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {},
                        icon: Image(
                          image: AssetImage(
                            widget.badanie.testType == "Morfologia"
                                ? 'assets/badanie_morfologia_logo.png'
                                : (widget.badanie.testType == "Gazometria"
                                    ? 'assets/badanie_gazometria_logo.png'
                                    : (widget.badanie.testType == "Lipidogram"
                                        ? 'assets/badanie_lipidogram_logo_small.png'
                                        : (widget.badanie.testType == 'Tarczyca'
                                            ? 'assets/badanie_tarczyca_logo_small.png'
                                            : 'assets/badanie_logo.png'))),
                          ),
                        ),
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                color: Theme.of(context).colorScheme.background,
                                style: BorderStyle.solid,
                                width: 4),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          widget.badanie.testType,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        )))),
                Expanded(
                    flex: 2,
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                color: Theme.of(context).colorScheme.background,
                                style: BorderStyle.solid,
                                width: 4),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          formatter.format(widget.badanie.createdAt),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        )))),
                Expanded(
                    flex: 8,
                    child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 4),
                          ),
                        ),
                        child: const Center())),
              ],
            ),
          ),
        ));
  }
}
