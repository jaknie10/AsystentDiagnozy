import 'package:flutter/material.dart';
import 'package:asystent_diagnozy/database/database_service.dart';

import '../badania/badanie_list_item_2.dart';

class Badania extends StatefulWidget {
  const Badania({
    super.key,
  });

  @override
  State<Badania> createState() => _BadaniaState();
}

class _BadaniaState extends State<Badania> {
  final SQLiteHelper helper = SQLiteHelper();
  String sortingType = 'createdAt';
  String sortingOrder = 'DESC';
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> sortingOptions = [
      const DropdownMenuItem(value: "createdAt", child: Text("Data badania")),
      const DropdownMenuItem(value: "testType", child: Text("Typ badania")),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text("Badania",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5)),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 15.0, bottom: 15.0, right: 15.0),
                    child: SizedBox(
                      height: 50,
                      width: 140,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(22, 20, 35, 1.0)),
                                elevation: 0,
                                value: sortingType,
                                items: sortingOptions,
                                onChanged: (val) {
                                  setState(() {
                                    sortingType = val.toString();
                                  });
                                  debugPrint(sortingType);
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (sortingOrder == 'ASC') {
                              sortingOrder = 'DESC';
                            } else {
                              sortingOrder = 'ASC';
                            }
                          });
                        },
                        icon: Icon((sortingOrder == 'ASC')
                            ? Icons.arrow_downward
                            : Icons.arrow_upward),
                        color: const Color.fromRGBO(22, 20, 35, 1.0),
                        highlightColor: Theme.of(context).colorScheme.secondary,
                        hoverColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0)),
                  ),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    style: BorderStyle.solid,
                                    width: 5),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Image(
                                image: AssetImage('assets/badanie_logo.png'),
                              ),
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      style: BorderStyle.solid,
                                      width: 5),
                                ),
                              ),
                              child: const Center(
                                  child: Text(
                                "Typ badania",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ))),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      style: BorderStyle.solid,
                                      width: 5),
                                ),
                              ),
                              child: const Center(
                                  child: Text(
                                "Data badania",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ))),
                        ),
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                            ),
                            child: Container(
                                height: 60,
                                decoration: const BoxDecoration(),
                                child: const Center(
                                  child: Text(
                                    "Pacjent",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )),
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 25.0, top: 5.0, bottom: 15.0),
                  child: FutureBuilder(
                      future: helper.getTests("$sortingType $sortingOrder"),
                      builder: (context, snapshot) {
                        // if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return const Center(child: CircularProgressIndicator());
                        // } else
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Text(
                              "Brak badań",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          );
                        } else {
                          final tests = snapshot.data!;
                          // print(badania.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: tests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BadanieListItem2(
                                badanie: tests[index],
                              );
                            },
                          );
                        }
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
