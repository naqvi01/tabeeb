import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zakatrebuild/models/surveysdata.dart';
import 'package:zakatrebuild/surveydescription.dart';

class SurveysList extends StatefulWidget {
  const SurveysList({super.key});

  @override
  State<SurveysList> createState() => _SurveysListState();
}

class _SurveysListState extends State<SurveysList> {
  List<ZakatSurveys> surveyItems = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection('Survey_List').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((news) => ZakatSurveys(
            id: news.id,
            description: news['description'],
            title: news['title'],
            img_src: news['img_src']))
        .toList();

    setState(() {
      surveyItems = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            itemCount: surveyItems.length,
            itemBuilder: (context, index) {
              print(surveyItems[index].description);
              return GestureDetector(
                onTap: () {
                  // Navigate to the details screen on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SurveyDetailsScreen(surveyItem: surveyItems[index]),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              surveyItems[index].img_src,
                              height: 72,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            surveyItems[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
