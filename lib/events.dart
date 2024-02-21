import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  List<String> titleevents = [
    "Pray for Turkey / Syria",
  ];
  List<String> titleimg = ["assets/images/turkey.png"];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titleevents.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, ind) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        titleimg[ind],
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        titleevents[ind],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
