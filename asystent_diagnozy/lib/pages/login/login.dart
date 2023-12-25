import 'package:asystent_diagnozy/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

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
                                width: 300,
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
                                              top: 15.0,
                                              bottom: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: const [],
                                            onSaved: (value) {},
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {}
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Icon(
                                                  Icons.person_outline_rounded,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                                  size: 25,
                                                ),
                                              ),
                                              hintText: "Login",
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 5.0,
                                              bottom: 15.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: const [],
                                            onSaved: (value) {},
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {}
                                              return null;
                                            },
                                            decoration: InputDecoration(
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Layout(),
                              ));
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
