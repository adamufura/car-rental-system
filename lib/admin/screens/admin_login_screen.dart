import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/admin_homepage_screen.dart';
import 'package:gac_car_rental/onboarding_screen.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../api/log_in.dart';
import '../configs/SizeConfig.dart';

class AdminLoginScreen extends StatefulWidget {
  static const routeName = "/adminLoginScreen";
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  var isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ADMIN LOGIN',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'LOGIN (ADMINS ONLY)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter Username',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        isLoading
                            ? Container(
                                margin: EdgeInsets.all(6),
                                child: CircularProgressIndicator())
                            : Container(),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          child: OutlinedButton.icon(
                            icon: Icon(
                              UniconsLine.signout,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Go-to Dashboard',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              // save
                              Response? res = await LogIn(
                                username: usernameController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              if (res!.statusCode == 200) {
                                print(res.body);
                                Map<dynamic, dynamic> result =
                                    jsonDecode(res.body);
                                if (result.containsKey('error')) {
                                  // show snackbar
                                  SnackBar snackBar = SnackBar(
                                    content: Text(result['error']),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  if (result.containsKey('status')) {
                                    // create user session
                                    final prefs =
                                        await SharedPreferences.getInstance();

                                    await prefs.setString(
                                        'car-rental',
                                        jsonEncode({
                                          'type': 'admin',
                                          'username': result['username'],
                                          'password': result['password']
                                        }));

                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pushReplacementNamed(
                                        AdminHomePageScreen.routeName);
                                  }
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              side: BorderSide(
                                width: 1.5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          TextButton.icon(
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  OnBoardingScreen.routeName);
                            },
                            label: Text(
                              'Exit',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
