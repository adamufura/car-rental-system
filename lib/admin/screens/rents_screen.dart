import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/api/car.dart';

import '../api/init.dart';
import '../configs/SizeConfig.dart';
import '../widgets/logout.dart';
import 'admin_homepage_screen.dart';

class RentsScreen extends StatefulWidget {
  const RentsScreen({super.key});

  @override
  State<RentsScreen> createState() => _RentsScreenState();
}

class _RentsScreenState extends State<RentsScreen> {
  @override
  void initState() {
    getAllRentedCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Rents"),
        centerTitle: true,
        leading: DrawerWidget(),
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: FutureBuilder(
          future: getAllRentedCars(),
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
                child: Text('No Bookings, check back later'),
              );
            }

            return snapshot.hasData
                ? SingleChildScrollView(
                    child: Column(
                      children: List.generate(snapshot.data['size'], (index) {
                        String curCar =
                            "${Init.urlInit}cars/${snapshot.data['data'][index]['image']}";

                        return Container(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Image.network(
                                        curCar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Car Name: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${snapshot.data['data'][index]['name']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rented By: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${snapshot.data['data'][index]['email']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Amount: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "N${snapshot.data['data'][index]['amount']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rented On: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${snapshot.data['data'][index]['datetime']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'To be return On: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${snapshot.data['data'][index]['due']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Status: ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Chip(
                                          padding: EdgeInsets.all(3),
                                          backgroundColor: Colors.deepPurple,
                                          label: Text(
                                            "${snapshot.data['data'][index]['status']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        child: Text('RETURNED'),
                                        onPressed: () async {
                                          var res = await returnRentedCar(
                                            id: snapshot.data['data'][index]
                                                ['id'],
                                            carID: snapshot.data['data'][index]
                                                ['car_id'],
                                            email: snapshot.data['data'][index]
                                                ['email'],
                                          );

                                          if (res['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "User successfully returned the car"),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("Something went wrong"),
                                            ));
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
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
    );
  }
}
