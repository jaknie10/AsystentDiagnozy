import 'package:asystent_diagnozy/models/patient.dart';
import 'package:flutter/material.dart';
import 'add_new_patient.dart';
import 'patient_list_item.dart';
import 'package:asystent_diagnozy/database/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SQLiteHelper helper = SQLiteHelper();
  String sortingType = 'datecreated';
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
      const DropdownMenuItem(value: "birthdate", child: Text("Data urodzenia")),
      const DropdownMenuItem(value: "surname", child: Text("Nazwisko")),
      const DropdownMenuItem(value: "datecreated", child: Text("Data dodania")),
    ];

    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 40,
                  width: 220,
                  child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddNewPatient(),
                          ),
                        ).then((value) => setState(() {}));
                      },
                      style: IconButton.styleFrom(
                        highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Dodaj nowego pacjenta",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ),
              SizedBox(
                width: 220,
                height: 40,
                child: SearchBar(
                  leading: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchValue = value;
                    });
                  },
                  elevation: MaterialStateProperty.all(2.0),
                  overlayColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                  shape: MaterialStateProperty.all(
                    const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Sortuj według:',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        height: 40,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
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
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
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
                              : Icons.arrow_upward)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: FutureBuilder<List<Patient>>(
              future:
                  helper.getPatients("$sortingType $sortingOrder", searchValue),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const Center(child: CircularProgressIndicator());
                // } else
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Brak pacjentów.'));
                } else {
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return PatientListItem(patient: users[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
