import 'package:flutter/material.dart';
import 'package:zakatrebuild/donatecards.dart';

class Subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Total Donation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '\$10000.00',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 21, 21),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Till now ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/5screen'),
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 33, 248, 165),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  'Track Subscription',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                )),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/3screen');
                  },
                  child: Cards(
                    image: AssetImage('assets/images/donateclothesicon.png'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/4screen');
                  },
                  child: Cards(
                    image: AssetImage('assets/images/foodhandicon.png'),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
