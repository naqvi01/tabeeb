import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zakatrebuild/exploredescription.dart';
import 'package:zakatrebuild/models/exploredata.dart';
import 'package:zakatrebuild/models/newsdata.dart';

class ExploreList extends StatefulWidget {
  @override
  State<ExploreList> createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  List<Zakatexplore> exploreItems = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection('Explore_List').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((news) => Zakatexplore(
            id: news.id,
            description: news['description'],
            title: news['title'],
            img_src: news['img_src']))
        .toList();

    setState(() {
      exploreItems = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            itemCount: exploreItems.length,
            itemBuilder: (context, index) {
              print(exploreItems[index].description);
              return GestureDetector(
                onTap: () {
                  // Navigate to the details screen on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExploreDetailScreen(exploreItem: exploreItems[index]),
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
                              exploreItems[index].img_src,
                              height: 72,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            exploreItems[index].title,
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
