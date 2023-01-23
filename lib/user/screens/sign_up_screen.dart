import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/sign_up.dart';
import 'package:gac_car_rental/user/screens/home_screen.dart';
import 'package:gac_car_rental/user/screens/sign_in_screen.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import '../configs/SizeConfig.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/userSignUp";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isLoading = false;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                          'Sign Up',
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
                  flex: 3,
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
                            'Create a new account',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: fullnameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter Full Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter Phone Number',
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
                              'Sign Up',
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
                              Response? res = await signUp(
                                fullname: fullnameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              if (res!.statusCode == 200) {
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
                                          'type': 'user',
                                          'email': result['email'],
                                          'password': result['password']
                                        }));

                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pushReplacementNamed(
                                        HomeScreen.routeName);
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
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignInScreen.routeName);
                            },
                            child: Text('Sign In'),
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
