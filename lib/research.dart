import 'package:flutter/material.dart';
import 'package:zakatrebuild/articlelist.dart';
import 'package:zakatrebuild/researchlist.dart';
import 'package:zakatrebuild/surveyslist.dart';

class Research extends StatelessWidget {
  const Research({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveysList()),
                );
              },
              child: researchSection("Survey's")),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => articleList()),
                );
              },
              child: researchSection("Article's")),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => researchList()),
                );
              },
              child: researchSection("Research's"))
        ],
      ),
    );
  }

  Widget researchSection(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Amaranth"),
            ),
            Icon(
              Icons.arrow_right,
              size: 70,
            )
          ],
        ),
      ),
    );
  }
}
