import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zakatrebuild/bottomnavbar.dart';
import 'package:zakatrebuild/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAtZW1d7WXu60fkbpYSUjVvXCr5g5Icjdk",
          appId: "1:508013717827:android:ade1ba5eeeb86d018467f6",
          messagingSenderId: "508013717827",
          projectId: "zakat-e48f2"));
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: Color.fromARGB(255, 29, 2, 182)),
      routes: {
        // '/0screen': (BuildContext context) => LoginScreen(),
        // '/1screen': (BuildContext context) => SignUpScreen(),
        '/2screen': (BuildContext context) => BottomNavigation(),
        // '/3screen': (BuildContext context) => DonateClothes(),
        // '/4screen': (BuildContext context) => DonateFoods(),
        // '/5screen': (BuildContext context) => TrackSubscription(),
        // '/6screen': (BuildContext context) => FoodDonationForm(),
        // '/7screen': (BuildContext context) => ClothesDonationForm(),
        // '/8screen': (BuildContext context) => DoctorsGpt(),
      },
    );
  }
}
