import 'dart:ui';

import 'package:flutter/material.dart';

class HowToScreen extends StatefulWidget {
  const HowToScreen({super.key});

  @override
  State<HowToScreen> createState() => _HowToScreenState();
}

class _HowToScreenState extends State<HowToScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to use'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'If a driver decides to rent a car beforehand, they go to a car rental website or app and find a vehicle that meets their needs. Then, they book it and pay for the chosen rental period, if upfront payment is required.',
                  style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                ),
                SizedBox(height: 40),
                Text(
                  'On the appointed day, this customer arrives at the car rental location to pick up the chosen car. An agent makes copies of their IDs, explains the terms of the lease, instructs them on any special features of the car, and finally hands them the keys. When the customer drops off the car, the agent checks its mileage and inspects for any damages.',
                  style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                ),
                SizedBox(height: 40),
                Text(
                  'One-way car rental deals are quite common, as they give people even more freedom to explore and enjoy their rental. However, rental companies will often charge a One Way Fee (or ‘drop charge’) to cover the cost of returning the car to its original location. As the world’s biggest online car rental service, we can help you find a one-way rental car with a low Fee – or no Fee at all.',
                  style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
