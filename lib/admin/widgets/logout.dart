import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../onboarding_screen.dart';
import 'alert_dialogue.dart';

logout(BuildContext context) {
  VoidCallback continueCallBack = () async {
    // sign user out
    final prefs = await SharedPreferences.getInstance();

    final signOut = await prefs.remove('car-rental');

    if (signOut) {
      Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()),
        (route) => false,
      );
    }
  };
  BlurryDialog alert = BlurryDialog(
      "Log Out", "Are you sure you want to Log Out? ", continueCallBack);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
