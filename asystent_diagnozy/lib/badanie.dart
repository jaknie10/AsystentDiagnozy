import 'package:flutter/material.dart';

class Badanie extends StatefulWidget {
  const Badanie({
    super.key,
    required this.badanieId,
  });

  final int badanieId;

  @override
  State<Badanie> createState() => _BadanieState();
}

class _BadanieState extends State<Badanie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 225, 17, 44),
      child: Center(
        child: Column(
          children: [
            Text(
                'Badanie' +
                    " badanieId:" +
                    widget.badanieId.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Powrót"))
          ],
        ),
      ),
    );
  }
}
