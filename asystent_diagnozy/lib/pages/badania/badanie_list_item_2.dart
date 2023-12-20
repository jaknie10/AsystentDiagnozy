import 'package:asystent_diagnozy/badania/test_results_widget.dart';
import 'package:asystent_diagnozy/models/test_result_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:asystent_diagnozy/database/database_service.dart';

class BadanieListItem2 extends StatefulWidget {
  const BadanieListItem2({
    super.key,
    required this.badanie,
  });

  final TestResult badanie;

  @override
  State<BadanieListItem2> createState() => _BadanieListItem2State();
}

class _BadanieListItem2State extends State<BadanieListItem2> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  final SQLiteHelper helper = SQLiteHelper();

  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Material(
          child: InkWell(
            child: Ink(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                color: Theme.of(context).colorScheme.background,
                                style: BorderStyle.solid,
                                width: 5),
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
                                          : (widget.badanie.testType ==
                                                  'Tarczyca'
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
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            widget.badanie.testType,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          )))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            formatter.format(widget.badanie.createdAt),
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          )))),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder(
                        future: helper.getPatientById(widget.badanie.patientId),
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState == ConnectionState.waiting) {
                          //   return const Center(child: CircularProgressIndicator());
                          // } else
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return const Center(child: Text('Error.'));
                          } else {
                            final tests = snapshot.data!;
                            return Center(
                                child: Text("${tests.surname} ${tests.name}"));
                          }
                        }),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestResultsWidget(
                          patientId: widget.badanie.patientId,
                          results: widget.badanie.results["results"],
                          interpretations:
                              widget.badanie.results["interpretations"],
                          classification:
                              widget.badanie.results["clasification"],
                          fromDatabase: true,
                          createdAt: DateTime.now().toString(),
                          testName: widget.badanie.testType)));
            },
          ),
        ));
  }
}
