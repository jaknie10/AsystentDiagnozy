import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 4.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white),
        child: 
        Row(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                decoration: BoxDecoration( border: Border( right: BorderSide(color: Theme.of(context).colorScheme.background, style: BorderStyle.solid, width: 4),),),
                child: 
                IconButton(
                  onPressed: () async {
                  },
                  icon: Image(
                    image: AssetImage(
                      widget.typBadania == "Morfologia" ?  'assets/badanie_morfologia_logo.png'
                      : (widget.typBadania == "Gazometria" ? 'assets/badanie_gazometria_logo.png' :'assets/badanie_logo.png'),
                    ),                
                    
                  ),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                          ),)),
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                decoration: BoxDecoration( border: Border( right: BorderSide(color: Theme.of(context).colorScheme.background, style: BorderStyle.solid, width: 4),),),
                child: Center(child: Text(widget.typBadania, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.normal),)))),
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                decoration: BoxDecoration( border: Border( right: BorderSide(color: Theme.of(context).colorScheme.background, style: BorderStyle.solid, width: 4),),),
                child: Center(child: Text(widget.dataBadania.toString().substring(0,10), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.normal),)))),
            Expanded(
              flex: 6,
              child: Container(
                height: 60,
                decoration: BoxDecoration( border: Border( right: BorderSide(color: Theme.of(context).colorScheme.background, style: BorderStyle.solid, width: 4),),),
                child: Center())),
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    child: TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Badanie(badanieId: widget.badanieId),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          highlightColor: const Color.fromRGBO(0, 84, 210, 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Container(
                          width: 80,
                          child: Text(
                            "Otwórz",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15,),
                                textAlign: TextAlign.center,
                          ),
                        )),
                  ),))),
          ],),
    ),);
  }
}
