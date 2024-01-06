import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:asystent_diagnozy/pages/login/choose_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'encryption_decryption_system.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class NewUser {
  String login;
  String rsaPublicKey;
  String encryptedPrivateKey;
  String saltOne;
  String saltTwo;

  NewUser(
      {required this.login,
      required this.rsaPublicKey,
      required this.encryptedPrivateKey,
      required this.saltOne,
      required this.saltTwo});
}

class _RegisterState extends State<Register> {
  final SQLiteHelper helper = SQLiteHelper();

  var password = '';
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Center(child: Text("UWAGA")),
              content: const Text(
                  '''Aplikacja "Asystent Diagnozy" jest tylko i wyłącznie pomocą przy stawianiu diagnozy. Aplikacja bazuje jedynie na wynikach badań, a ostatecznej diagnozy opartej na analizie wszystkich czynników i objawów pacjenta dokonuje lekarz.
Aplikacja działa w pełni lokalnie, na zainstalowanym urządzeniu, żadne z podanych w aplikacji danych nie jest nigdzie wysyłana ani dalej przetwarzana.'''),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text("ROZUMIEM"))
              ],
              actionsAlignment: MainAxisAlignment.center));
    });
  }

  final _formKey = GlobalKey<FormState>();

  NewUser newUser = NewUser(
      login: '',
      rsaPublicKey: '',
      encryptedPrivateKey: '',
      saltOne: '',
      saltTwo: '');

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
                      child: Image.asset(
                        'assets/logo_new.png',
                        width: 160,
                      )),
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
                              const Padding(
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
                                        const Padding(
                                          padding: EdgeInsets.only(
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
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^[A-Za-z0-9]+$'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                newUser.login =
                                                    value.toString();
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length < 4) {
                                                return "Login powinien zawierać co najmniej 4 znaków";
                                              }
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
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
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
                                            obscureText: !passwordVisible,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^.+$'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                password = value.toString();
                                              });
                                            },
                                            onFieldSubmitted: (value) async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var check = await helper
                                                    .checkIfUserInDatabase(
                                                        newUser.login);
                                                if (!context.mounted) return;
                                                if (int.parse(check) != 0) {
                                                  debugPrint(
                                                      "taki użytkownik juz jest w bazie");
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            content: const Text(
                                                                "Użytkownik o takim loginie znajduje się już w bazie danych. Podaj inny login."),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                          "Ok")),
                                                            ],
                                                          ));
                                                } else {
                                                  PrivateKeyEncryptionResult
                                                      signUpResult =
                                                      signUp(password);

                                                  helper.addUserToDatabase(
                                                      newUser.login,
                                                      signUpResult.publicKey,
                                                      signUpResult
                                                          .encryptedPrivateKey,
                                                      signUpResult
                                                          .randomSaltOne,
                                                      signUpResult
                                                          .randomSaltTwo);

                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ChooseUser(),
                                                      ));
                                                }
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length < 8) {
                                                return "Hasło powinno zawierać co najmniej 8 znaków";
                                              }
                                              return null;
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
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
                                          child: Text(
                                            "* Hasło powinno zawierać co najmniej 8 znaków",
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var check =
                                            await helper.checkIfUserInDatabase(
                                                newUser.login);
                                        if (!context.mounted) return;
                                        if (int.parse(check) != 0) {
                                          debugPrint(
                                              "taki użytkownik juz jest w bazie");
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    content: const Text(
                                                        "Użytkownik o takim loginie znajduje się już w bazie danych. Podaj inny login."),
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
                                          PrivateKeyEncryptionResult
                                              signUpResult = signUp(password);

                                          helper.addUserToDatabase(
                                              newUser.login,
                                              signUpResult.publicKey,
                                              signUpResult.encryptedPrivateKey,
                                              signUpResult.randomSaltOne,
                                              signUpResult.randomSaltTwo);

                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChooseUser(),
                                              ));
                                        }
                                      }
                                    },
                                    style: IconButton.styleFrom(
                                      highlightColor:
                                          const Color.fromRGBO(0, 84, 210, 1),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
      ),
    );
  }
}
