import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zakatrebuild/models/newsdata.dart';
import 'package:zakatrebuild/newsdescription.dart';

class NewsList extends StatefulWidget {
  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Zakatnews> newsItems = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection('News_List').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((news) => Zakatnews(
            id: news.id,
            description: news['description'],
            title: news['title'],
            img_src: news['img_src']))
        .toList();

    setState(() {
      newsItems = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              print(newsItems[index].description);
              return GestureDetector(
                onTap: () {
                  // Navigate to the details screen on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsDetailsScreen(newsItem: newsItems[index]),
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
                              newsItems[index].img_src,
                              height: 72,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            newsItems[index].title,
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
    ); // return StreamBuilder(
    //     stream: newsref.snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const CircularProgressIndicator();
    //       }

    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //           physics: BouncingScrollPhysics(),
    //           itemBuilder: (context, index) {
    //             return Text(
    //               "",
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 50,
    //                   fontWeight: FontWeight.bold),
    //             );
    //           },
    //           itemCount: snapshot.data!.docs.length,
    //         );
    //       }
    //       // ${snapshot.data!.docs[index].data()['Title']}
    //       return Text(
    //         'There is no data',
    //         style: TextStyle(
    //             color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
    //       );
    //     });
    // return ListView.builder(
    //     itemCount: titlenews.length,
    //     physics: BouncingScrollPhysics(),
    //     itemBuilder: (context, ind) {
    //       return Column(
    //         children: [
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    //             width: double.infinity,
    //             height: 80,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(20)),
    //             child: Row(children: [
    //               SizedBox(
    //                 width: 20,
    //               ),
    //               Container(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     color: Colors.amber),
    //                 height: 50,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(5),
    //                   child: Image(
    //                     image: AssetImage(
    //                       'assets/images/hungrykid.jpg',
    //                     ),
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Expanded(
    //                   child: Text(
    //                 titlenews[ind],
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ))
    //             ]),
    //             // child: Center(
    //             //     child: Text(
    //             //   titlenews[ind],
    //             //   textAlign: TextAlign.center,
    //             //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //             // )),
    //           )
    //         ],
    //       );
    //     });
  }
}
