import 'package:asystent_diagnozy/models/pacjent.dart';
import 'package:flutter/material.dart';
import 'patient_list_item.dart';
import 'addNewPatient.dart';
import 'package:asystent_diagnozy/database/database_service.dart';

class Patient {
  final String imie;
  final String nazwisko;
  final DateTime dataUrodzenia;
  final String gender;
  final bool showDateOfBirth;
  final String buttonText;
  final int id;

  Patient({
    required this.imie,
    required this.nazwisko,
    required this.dataUrodzenia,
    required this.gender,
    required this.showDateOfBirth,
    required this.buttonText,
    required this.id,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  }

  List<Patient> patientList = [
    Patient(
      imie: "Jan",
      nazwisko: "Kowalski",
      dataUrodzenia: DateTime.utc(2000, 10, 10),
      gender: "M",
      showDateOfBirth: false,
      buttonText: "Profil",
      id: 1,
    ),
    Patient(
        imie: "Adam",
        nazwisko: "Nowak",
        dataUrodzenia: DateTime.utc(2023, 5, 10),
        gender: "M",
        showDateOfBirth: false,
        buttonText: "Profil",
        id: 2),
    Patient(
        imie: "XYZ",
        nazwisko: "ABC",
        dataUrodzenia: DateTime.utc(2010, 10, 8),
        gender: "K",
        showDateOfBirth: false,
        buttonText: "Profil",
        id: 3),
    Patient(
        imie: "Jan",
        nazwisko: "Kowalski",
        dataUrodzenia: DateTime.utc(2000, 10, 10),
        gender: "M",
        showDateOfBirth: false,
        buttonText: "Profil",
        id: 4),
    Patient(
        imie: "Adam",
        nazwisko: "Nowak",
        dataUrodzenia: DateTime.utc(2023, 5, 10),
        gender: "M",
        showDateOfBirth: false,
        buttonText: "Profil",
        id: 5),
    Patient(
        imie: "XYZ",
        nazwisko: "ABC",
        dataUrodzenia: DateTime.utc(2010, 10, 8),
        gender: "K",
        showDateOfBirth: false,
        buttonText: "Profil",
        id: 6)
  ];
  List<Patient> filteredPatientList = [];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> sortingOptions = [
      const DropdownMenuItem(
          value: "Data urodzenia (rosnąco)",
          child: Text("Data urodzenia (rosnąco)")),
      const DropdownMenuItem(
          value: "Data urodzenia (malejąco)",
          child: Text("Data urodzenia (malejąco)")),
      const DropdownMenuItem(value: "A-Z", child: Text("A-Z")),
      const DropdownMenuItem(value: "Z-A", child: Text("Z-A")),
    ];

    if (filteredPatientList.length == 0) {
      filteredPatientList = patientList;
    }

    void filterList(String searchText) {
      setState(() {
        filteredPatientList = patientList
            .where((logObj) =>
                (logObj.imie + " " + logObj.nazwisko)
                    .toLowerCase()
                    .trim()
                    .contains(searchText.toLowerCase()) ||
                logObj.id.toString().toLowerCase().trim().contains(searchText))
            .toList();
      });
    }

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
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddNewPatient(),
                          ),
                        );*/
                        await helper.batchInsert();
                        setState(() {});
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
            ],
          ),
          Flexible(
            child: FutureBuilder<List<Pacjent>>(
              future: helper.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No users found.'));
                } else {
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return PatientListItem(
                        name: users[index].name,
                        surname: users[index].surname,
                        sex: users[index].sex,
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
