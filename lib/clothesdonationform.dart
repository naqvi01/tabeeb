import 'package:flutter/material.dart';
import 'package:zakatrebuild/form.dart';

class ClothesDonationForm extends StatefulWidget {
  @override
  State<ClothesDonationForm> createState() => _ClothesDonationFormState();
}

class _ClothesDonationFormState extends State<ClothesDonationForm> {
  int person = 1;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Donate Clothes Details',
          style: TextStyle(
              fontFamily: 'PatrickHand', color: Colors.white, fontSize: 30),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Forms(
                label: Text('Name'),
              ),
              Forms(
                label: Text('Clothes Type'),
              ),
              Forms(
                label: Text('Prefered Time'),
              ),
              Forms(
                label: Text('Pickup Day'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Quantity : ' + '$person' + ' Person',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SliderTheme(
                  data: SliderThemeData(
                      thumbColor: Colors.amber,
                      activeTrackColor: Colors.amber,
                      inactiveTrackColor: Color.fromARGB(94, 255, 255, 255),
                      thumbShape: RoundSliderThumbShape(
                          disabledThumbRadius: 20, enabledThumbRadius: 10)),
                  child: Slider(
                    min: 1,
                    max: 10000,
                    value: person.toDouble(),
                    onChanged: (double val) {
                      setState(() {
                        person = val.toInt();
                        print(person);
                      });
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        print('Submitted');

                        final snackBar = SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'Succesfully Submitted',
                              style: TextStyle(color: Colors.blue),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  )),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'images/zakatlogo.png',
                height: 20,
              )
            ],
          ),
        )),
      ),
    );
  }
}
