import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:asystent_diagnozy/layout.dart';
import 'package:asystent_diagnozy/models/user_model.dart';
import 'package:asystent_diagnozy/pages/login/encryption_decryption_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({
    super.key,
    required this.userName,
    required this.userSurname,
    required this.userLogin,
  });

  final String userName;
  final String userSurname;
  final String userLogin;

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _formKey = GlobalKey<FormState>();
  var password = '';
  bool passwordVisible = false;

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
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SvgPicture.asset(
                      'assets/asystent_diagnozy_logo.svg',
                      width: 160,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 400,
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
                                          child: Text(
                                            "Zaloguj się",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              bottom: 15.0),
                                          child: Text(
                                            "${widget.userName} ${widget.userSurname}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 5.0,
                                              bottom: 15.0),
                                          child: TextFormField(
                                            obscureText: passwordVisible,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^.+$'))
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length < 10) {
                                                return "Hasło powinno zawierać co najmniej 10 znaków";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                password = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0),
                                                child: IconButton(
                                                  icon: Icon(passwordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        passwordVisible =
                                                            !passwordVisible;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Icon(
                                                  Icons.lock_outline_rounded,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                                  size: 25,
                                                ),
                                              ),
                                              hintText: "Hasło",
                                              hintStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2),
                                                fontSize: 18,
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
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            User userData =
                                await helper.getUserLoginData(widget.userLogin);
                            if (!context.mounted) return;

                            if (login(userData.saltOne, userData.saltTwo,
                                    userData.encryptedPrivateKey, password)
                                .privateKey
                                .toString()
                                .isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: const Text("Podano złe hasło"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Ok")),
                                        ],
                                      ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Layout(
                                      user: userData,
                                    ),
                                  ));
                            }
                          }
                        },
                        style: IconButton.styleFrom(
                          highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: 80,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Zaloguj",
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
              ),
            )),
      ),
    );
  }
}
