import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:asystent_diagnozy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../login/encryption_decryption_system.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final SQLiteHelper helper = SQLiteHelper();

  String currentPass = '';
  String newPass = '';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
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
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 500,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text("Zmień hasło:",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0,
                                    left: 15.0,
                                    right: 15.0,
                                    bottom: 5.0),
                                child: SizedBox(
                                  width: 300,
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 5.0, top: 5.0),
                                            child: Text(
                                              "Wprowadź stare hasło:",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: const [],
                                            onSaved: (value) {},
                                            onChanged: (value) {
                                              setState(() {
                                                currentPass = value;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length < 10) {
                                                return "Hasło powinno zawierać co najmniej 10 znaków";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Icon(
                                                  Icons.lock_outline_rounded,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                                  size: 25,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 5.0, top: 15.0),
                                            child: Text(
                                              "Wprowadź nowe hasło:",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              inputFormatters: const [],
                                              onSaved: (value) {},
                                              onChanged: (value) {
                                                setState(() {
                                                  newPass = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length < 10) {
                                                  return "Hasło powinno zawierać co najmniej 10 znaków";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                prefixIcon: const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Icon(
                                                    Icons.lock_outline_rounded,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.2),
                                                    size: 25,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              "* Hasło powinno zawierać przynajmniej 10 znaków",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(99, 99, 99, 1.0)),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, top: 15.0),
                              child: TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var newData = resetPassword(
                                          widget.user.encryptedPrivateKey,
                                          widget.user.rsaPublicKey,
                                          widget.user.saltOne,
                                          widget.user.saltTwo,
                                          currentPass,
                                          newPass);

                                      if (newData.encryptedPrivateKey.isEmpty ||
                                          newData.encryptedPrivateKey ==
                                              widget.user.encryptedPrivateKey) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: const Text(
                                                      "Błąd we wprowadzonych danych"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text("Ok")),
                                                  ],
                                                ));
                                      } else {
                                        await helper.updateUserPassword(
                                            newData.publicKey,
                                            newData.encryptedPrivateKey,
                                            newData.randomSaltOne,
                                            newData.randomSaltTwo,
                                            widget.user.login);
                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  style: IconButton.styleFrom(
                                    highlightColor:
                                        const Color.fromRGBO(0, 84, 210, 1),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  child: const SizedBox(
                                    width: 110,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "Zapisz hasło",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
