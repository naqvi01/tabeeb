import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingSlider extends StatefulWidget {
  const TrendingSlider({super.key});

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  late Stream<QuerySnapshot> imageStream;
  int currentSlideIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("imgslider").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: imageStream,
          builder: (_, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.length >= 1) {
              return CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index, ___) {
                  DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      sliderImage['img'], // corrected field name
                      fit: BoxFit.contain,
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentSlideIndex = index;
                    });
                  },
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
