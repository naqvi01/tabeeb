import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final ImageProvider? image;
  Cards({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 33, 248, 165),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: CircleAvatar(
            radius: 52,
            backgroundColor: Color.fromARGB(255, 255, 0, 25),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: image,
              backgroundColor: Colors.white,
            )),
      ),
    );
  }
}
