import 'package:asystent_diagnozy/pages/home/home.dart';
import 'package:asystent_diagnozy/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Users extends StatefulWidget {
  const Users({
    super.key,
  });

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                            SizedBox(
                              width: 300,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [],
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
