import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
    required this.doctorId,
  });

  final doctorId;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, widget.doctorId);
                      },
                      style: IconButton.styleFrom(
                        highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        "Powrót",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Wprowadź nowe hasło",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: EdgeInsets.all(15.0),
                              //   child: Text(
                              //     "Nowe hasło:",
                              //     style: TextStyle(
                              //       fontSize: 18,
                              //     ),
                              //   ),
                              // ),
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
                                          TextFormField(
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
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
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
                                  onPressed: () {
                                    Navigator.pop(context, widget.doctorId);
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
                                        "Zmień hasło",
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
