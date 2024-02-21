import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zakatrebuild/models/research.dart';
import 'package:zakatrebuild/researchdescription.dart';

class researchList extends StatefulWidget {
  const researchList({super.key});

  @override
  State<researchList> createState() => _researchListState();
}

class _researchListState extends State<researchList> {
  List<Zakatresearch> researchItems = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection('Research_List').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((news) => Zakatresearch(
            id: news.id,
            description: news['description'],
            title: news['title'],
            img_src: news['img_src']))
        .toList();

    setState(() {
      researchItems = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        title: Text(
          'Researches',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            itemCount: researchItems.length,
            itemBuilder: (context, index) {
              print(researchItems[index].description);
              return GestureDetector(
                onTap: () {
                  // Navigate to the details screen on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResearchDetailsScreen(
                          researchItem: researchItems[index]),
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
                              researchItems[index].img_src,
                              height: 72,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            researchItems[index].title,
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
