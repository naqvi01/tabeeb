import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateClothes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Clothes Donation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  width: 250,
                  height: 180,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/clothesdonateimg.png',
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Donate For Needy People ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'By Zakat ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Want To Donate Clothes ?',
                style: TextStyle(
                    fontFamily: 'PatrickHand',
                    color: Colors.white,
                    fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/7screen');
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundImage: AssetImage('images/donateclothesicon.png'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Donate',
                style: TextStyle(
                    fontFamily: 'PatrickHand',
                    color: Colors.white,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/zakatlogo.png',
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
