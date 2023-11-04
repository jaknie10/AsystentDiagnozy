import 'package:flutter/material.dart';

class BadanieListItem extends StatelessWidget {
  const BadanieListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white),
        child:  Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                  
                  ],
                ),
              ),
              Row(
                children: [
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
