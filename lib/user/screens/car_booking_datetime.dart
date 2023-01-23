import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/screens/payment_screen.dart';
import 'package:unicons/unicons.dart';

import '../api/init.dart';
import '../configs/SizeConfig.dart';

class CarBookingDateTime extends StatefulWidget {
  static const routeName = "/carDateTimeScreen";

  const CarBookingDateTime({super.key});

  @override
  State<CarBookingDateTime> createState() => _CarBookingDateTimeState();
}

class _CarBookingDateTimeState extends State<CarBookingDateTime> {
  // Initial Selected Value
  String dropdownvalue = '1 Day';
  String amount = '';
  int total = 0;

// List of items in our dropdown menu
  var items = [
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    int currentID = arguments['carID'];
    String name = arguments['name'];
    String image = arguments['image'];
    amount = arguments['price'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Date & Time'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.network(
              "${Init.urlInit}cars/${image}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${name}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'N${dropdownvalue == "1 Day" ? amount : total} in ${dropdownvalue}',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)),
                  color: Colors.deepPurple,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Select number of days',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                total = int.parse(dropdownvalue[0]) *
                                    int.parse(amount);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PaymentScreen.routeName,
                                arguments: {
                                  'carID': currentID,
                                  'days': dropdownvalue,
                                  'total':
                                      dropdownvalue == "1 Day" ? amount : total
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey, // Background color
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
