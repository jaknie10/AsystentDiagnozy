import 'package:asystent_diagnozy/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

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
                        child: Text(
                          "Powrót",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Text("Zarejestruj się",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              width: 400,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 15.0),
                                        child: Text(
                                          "Imię:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 10.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          inputFormatters: [],
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {}
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 15.0),
                                        child: Text(
                                          "Nazwisko:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 10.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          inputFormatters: [],
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {}
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 15.0),
                                        child: Text(
                                          "Numer PWZ:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 10.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          inputFormatters: [],
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {}
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 15.0),
                                        child: Text(
                                          "Login:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 10.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          inputFormatters: [],
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {}
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0, top: 15.0),
                                        child: Text(
                                          "Hasło:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          inputFormatters: [],
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {}
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Text(
                                          "* Hasło powinno zawierać przynajmniej 10 znaków",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  99, 99, 99, 1.0)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
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
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "Zarejestruj",
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
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
