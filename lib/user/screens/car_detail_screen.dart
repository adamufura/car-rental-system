import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/car.dart';
import 'package:gac_car_rental/user/screens/car_booking_datetime.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../api/init.dart';
import '../configs/SizeConfig.dart';
import '../providers/car_user_provider.dart';

class CarDetailScreen extends StatefulWidget {
  static const routeName = "/carDetailScreen";

  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  var carInfo;

  @override
  void initState() {
    Future(() {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      getACar(carID: arguments['carID']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int currentID = arguments['carID'];
    List<Widget> carDetails = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getACar(carID: currentID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              carDetails = [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.speed_outlined, size: 30),
                    ),
                    Text(
                      "${snapshot.data['data']['power']} KM",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.type_specimen_outlined, size: 30),
                    ),
                    Text(
                      "${snapshot.data['data']['type']}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.ev_station_outlined, size: 30),
                    ),
                    Text(
                      "${snapshot.data['data']['fuel']}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.car_rental_outlined, size: 30),
                    ),
                    Text(
                      "${snapshot.data['data']['seats']} Seats",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ];
            }

            return snapshot.hasData
                ? SafeArea(
                    child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          "${Init.urlInit}cars/${snapshot.data['data']['image']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data['data']['name']}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.deepPurple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepPurple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepPurple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepPurple,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data['data']['details'],
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
                                    'Overview',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 0.8,
                                      children:
                                          List<Widget>.generate(4, (index) {
                                        return GridTile(
                                          child: Card(
                                            color: Colors.blueGrey,
                                            child: carDetails[index],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'N${snapshot.data['data']['price']}/day',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 40,
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                CarBookingDateTime.routeName,
                                                arguments: {
                                                  'carID': snapshot.data['data']
                                                      ['id'],
                                                  'name': snapshot.data['data']
                                                      ['name'],
                                                  'image': snapshot.data['data']
                                                      ['image'],
                                                  'price': snapshot.data['data']
                                                      ['price']
                                                });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .blueGrey, // Background color
                                          ),
                                          child: Text(
                                            'Book Car',
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
