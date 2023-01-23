import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/car.dart';

import '../api/init.dart';
import '../configs/SizeConfig.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  void initState() {
    getUserRentedCars(email: "email");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'My Bookings',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getUserRentedCars(email: 'adamufura98@gmail.com'),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data['size'] < 1) {
                      return const Center(
                        child: Text('No Bookings, Book a Car'),
                      );
                    }

                    return snapshot.hasData
                        ? SingleChildScrollView(
                            child: Column(
                              children:
                                  List.generate(snapshot.data['size'], (index) {
                                String curCar =
                                    "${Init.urlInit}cars/${snapshot.data['data'][index]['image']}";

                                return Container(
                                  height: SizeConfig.safeBlockVertical * 20,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 3,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              curCar,
                                            ),
                                            Expanded(
                                                child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "${snapshot.data['data'][index]['name']}",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          'To be returned on "${snapshot.data['data'][index]['due']}"'),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          child: Chip(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            backgroundColor:
                                                                Colors
                                                                    .deepPurple,
                                                            label: Text(
                                                              "${snapshot.data['data'][index]['status']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                              }),
                            ),
                          )
                        : CircularProgressIndicator();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
