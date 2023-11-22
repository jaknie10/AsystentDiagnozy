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
  String sortingType = 'Data urodzenia (rosnąco)';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();

    //przykładowi pacjenci na początek
    helper.insertUSer(const Patient(id: 1, gender: 'K', name: 'Julia', surname: 'Nowak'));
    helper.insertUSer(const Patient(id: 2, gender: 'M', name: 'Jan', surname: 'Kowalski'));
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> sortingOptions = [
      const DropdownMenuItem(value: "Data urodzenia (rosnąco)", child: Text("Data urodzenia (rosnąco)")),
      const DropdownMenuItem(value: "Data urodzenia (malejąco)", child: Text("Data urodzenia (malejąco)")),
      const DropdownMenuItem(value: "A-Z", child: Text("A-Z")),
      const DropdownMenuItem(value: "Z-A", child: Text("Z-A")),
    ];

    // if (filteredPatientList.isEmpty) {
    //   filteredPatientList = patientList;
    // }

    // void filterList(String searchText) {
    //   setState(() {
    //     filteredPatientList = patientList
    //         .where((logObj) =>
    //             ("${logObj.imie} ${logObj.nazwisko}")
    //                 .toLowerCase()
    //                 .trim()
    //                 .contains(searchText.toLowerCase()) ||
    //             logObj.id.toString().toLowerCase().trim().contains(searchText))
    //         .toList();
    //   });
    // }

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
                        // await helper.batchInsert();
                        // setState(() {});
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
                width: 200,
                height: 40,
                /*child: SearchBar(
                  onTap: () {filterList("");},
                  onChanged:(value) => filterList(value),
                )*/
                child: TextButton(
                  onPressed: () async {
                    await helper.deleteAllUsers();
                    setState(() {});
                  },
                  child: const Text("DEL"),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            dropdownColor: Colors.white,
                            style: const TextStyle(fontSize: 15, color: Color.fromRGBO(22, 20, 35, 1.0)),
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
            ],
          ),
          Flexible(
            child: FutureBuilder<List<Patient>>(
              future: helper.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Brak pacjentów.'));
                } else {
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return PatientListItem(
                        name: users[index].name,
                        surname: users[index].surname,
                        gender: users[index].gender,
                        id: users[index].id,
                      );
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
