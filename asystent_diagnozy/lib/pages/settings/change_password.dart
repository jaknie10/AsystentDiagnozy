import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child:  Padding(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text("Zmień hasło", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text("zmień hasełko doktora o id ${widget.doctorId}")
                            ),],),),),),]),
            ],
          ),),),);
  }
}