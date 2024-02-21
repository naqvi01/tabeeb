import 'package:flutter/material.dart';

class CompititionList extends StatelessWidget {
  List<String> titlecompition = [
    "Making this App for UN Solutions by GDSC 1 (Compition Section)",
    "Making this App for UN Solutions by GDSC 2",
    "Making this App for UN Solutions by GDSC 3",
    "Making this App for UN Solutions by GDSC 4",
    "Making this App for UN Solutions by GDSC 5",
    "Making this App for UN Solutions by GDSC 6",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titlecompition.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, ind) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  titlecompition[ind],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              )
            ],
          );
        });
  }
}
