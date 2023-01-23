import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.deepPurple),
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: [
            TextButton(
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Sign Out",
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
              onPressed: () {
                continueCallBack();
              },
            ),
          ],
        ));
  }
}
