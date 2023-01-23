import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/admin_code_screen.dart';
import 'package:gac_car_rental/admin/screens/admin_homepage_screen.dart';
import 'package:gac_car_rental/user/screens/home_screen.dart';
import 'package:gac_car_rental/user/screens/sign_in_screen.dart';
import 'package:gac_car_rental/user/screens/sign_up_screen.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "/onboardingScreen";

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

Future isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final String? response = prefs.getString('car-rental');
  return response;
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    isLoggedIn().then((value) {
      if (value.toString().isNotEmpty && value != null) {
        Map<dynamic, dynamic> result = jsonDecode(value);
        if (result['type'] == 'user') {
          if (result.containsKey('email') && result.containsKey('password')) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }
        }
        if (result['type'] == 'admin') {
          if (result.containsKey('username') &&
              result.containsKey('password')) {
            // login admin
            Navigator.of(context)
                .pushReplacementNamed(AdminHomePageScreen.routeName);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: OnBoardingAnimation(
          controller: PageController(initialPage: 1),
          pages: [
            _GetCardsContent(
              image: 'assets/images/sign-up.png',
              cardContent: "Don't have an account? SIGN UP here",
              button: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
                },
                child: Text('Sign Up'),
              ),
            ),
            _GetCardsContent(
              image: 'assets/images/log-in.png',
              cardContent: 'Already have an Account? SIGN IN here',
              button: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignInScreen.routeName);
                },
                child: Text('Sign In'),
              ),
            ),
            _GetCardsContent(
              image: 'assets/images/admin-cog.png',
              cardContent: 'Admin (Out Of Bounds for Users)',
              button: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AdminCodeScreen.routeName);
                },
                child: Text('Go-to Admin'),
              ),
            ),
          ],
          indicatorDotHeight: 7.0,
          indicatorDotWidth: 14.0,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
        ),
      ),
    );
  }
}

class _GetCardsContent extends StatelessWidget {
  final String image, cardContent;
  final Widget button;

  const _GetCardsContent(
      {Key? key,
      required this.image,
      required this.cardContent,
      required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              child: Image.asset(
                image,
                scale: 2,
              ),
            ),
            Text(
              cardContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.deepPurple,
              ),
            ),
            button,
          ],
        ),
      ),
    );
  }
}
