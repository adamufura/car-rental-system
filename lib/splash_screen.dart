import 'package:flutter/material.dart';
import 'package:gac_car_rental/onboarding_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class GACSplashScreen extends StatelessWidget {
  const GACSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: OnBoardingScreen(),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.deepPurple,
      photoSize: 150.0,
      loaderColor: Colors.deepPurpleAccent,
      loadingText: Text('Loading...'),
      title: Text(
        'GAC CAR RENTAL',
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
