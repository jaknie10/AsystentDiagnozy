import 'package:asystent_diagnozy/database/database_service.dart';
import 'package:flutter/material.dart';

import 'badanie.dart';

class BadanieListItem extends StatefulWidget {
  const BadanieListItem({
    super.key,
    required this.dataBadania,
    required this.typBadania,
    required this.badanieId,
  });

  final dataBadania;
  final typBadania;
  final badanieId;

  @override
  State<BadanieListItem> createState() => _BadanieListItemState();
}

class _BadanieListItemState extends State<BadanieListItem> {
  final SQLiteHelper helper = SQLiteHelper();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    helper.initWinDB();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 4.0),
      child: FutureBuilder(
          future: helper.getLipidogram(),
          builder: (context, snapshot) {
            return Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(color: Colors.white),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Badanie(badanieId: widget.badanieId),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  style: BorderStyle.solid,
                                  width: 4),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () async {},
                            icon: Image(
                              image: AssetImage(
                                widget.typBadania == "Morfologia"
                                    ? 'assets/badanie_morfologia_logo.png'
                                    : (widget.typBadania == "Gazometria"
                                        ? 'assets/badanie_gazometria_logo.png'
                                        : (widget.typBadania == "Lipidogram"
                                            ? 'assets/badanie_lipidogram_logo_small.png'
                                            : (widget.typBadania == 'Tarczyca'
                                                ? 'assets/badanie_tarczyca_logo_small.png'
                                                : 'assets/badanie_logo.png'))),
                              ),
                            ),
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    style: BorderStyle.solid,
                                    width: 4),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              widget.typBadania,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            )))),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    style: BorderStyle.solid,
                                    width: 4),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              widget.dataBadania.toString().substring(0, 10),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            )))),
                    Expanded(
                        flex: 8,
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 4),
                              ),
                            ),
                            child: Center())),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
