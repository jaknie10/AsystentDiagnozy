import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:asystent_diagnozy/pages/login/login_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseUser extends StatefulWidget {
  const ChooseUser({
    super.key,
  });

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 40,
                    width: 90,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: IconButton.styleFrom(
                          highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: SvgPicture.asset(
                  'assets/asystent_diagnozy_logo.svg',
                  width: 160,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 350.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: helper.getAllUsers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'Brak zarejestrowanych użytkowników'));
                                } else {
                                  final tests = snapshot.data!;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: tests.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                              width: 350,
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: InkWell(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: SvgPicture.asset(
                                                          'assets/lekarz_logo.svg',
                                                          width: 30,
                                                          fit: BoxFit.scaleDown,
                                                        ),
                                                      ),
                                                      Text(tests[index].login)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => LoginUser(
                                                                userLogin:
                                                                    tests[index]
                                                                        .login,
                                                                userId:
                                                                    tests[index]
                                                                        .id!)));
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
