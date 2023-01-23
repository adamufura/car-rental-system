import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/admin_login_screen.dart';

class AdminCodeScreen extends StatefulWidget {
  static const routeName = "/adminCodeScreen";
  const AdminCodeScreen({super.key});

  @override
  State<AdminCodeScreen> createState() => _AdminCodeScreenState();
}

class _AdminCodeScreenState extends State<AdminCodeScreen> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                hintText: 'Enter code to open admin login',
                labelText: 'Enter admin code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              child: Text('Open Admin Login'),
              onPressed: () {
                if (codeController.text.trim() == "2022") {
                  Navigator.of(context)
                      .pushReplacementNamed(AdminLoginScreen.routeName);
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text('Incorrect code!'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
