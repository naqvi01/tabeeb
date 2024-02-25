import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zakatrebuild/screens/doctorsgpt.dart';
import 'package:zakatrebuild/screens/homescreen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  final Screens = [HomeScreen(), DoctorsGpt()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GNav(
            onTabChange: (index) {
              setState(() {
                this.index = index;
              });
            },
            tabMargin: EdgeInsets.all(10),
            tabBackgroundColor: Colors.red,
            padding: EdgeInsets.all(10),
            gap: 8,
            backgroundColor: Color.fromARGB(255, 0, 178, 209),
            color: Colors.white,
            activeColor: Colors.white,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              // GButton(
              //   icon: Icons.money_rounded,
              //   text: 'Donation',
              // ),
              // GButton(
              //   icon: Icons.directions,
              //   text: 'Find',
              // ),
              GButton(
                icon: FontAwesomeIcons.userDoctor,
                text: 'Tabeeb',
              ),
            ]),
        body: Screens[index]);
  }
}
