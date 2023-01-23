import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gac_car_rental/admin/api/car.dart';
import 'package:gac_car_rental/admin/screens/add_car_screen.dart';
import 'package:http/http.dart';

import '../api/init.dart';
import '../widgets/logout.dart';
import 'admin_homepage_screen.dart';

class CarsScreen extends StatefulWidget {
  static const routeName = "/CarsScreen";
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  @override
  void initState() {
    getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cars"),
        centerTitle: true,
        leading: DrawerWidget(),
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: FutureBuilder(
        future: getAllCars(),
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
              child: Text('NO Car created, click on the + Button'),
            );
          }

          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data['size'],
                  itemBuilder: (context, index) {
                    List data = snapshot.data['data'];
                    int counter = index + 1;
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              Response response =
                                  await deleteCar(brandID: data[index]['id']);
                              if (response.statusCode == 200) {
                                Map<dynamic, dynamic> data =
                                    jsonDecode(response.body);
                                if (data['status'] == 'success') {
                                  setState(() {});
                                }
                              }
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Text(
                            counter.toString(),
                          )),
                          title: Text(data[index]['name']),
                          trailing: Image.network(
                            fit: BoxFit.contain,
                            Init.urlInit +
                                "cars/" +
                                data[index]['image'].toString().trim(),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddCarScreen.routeName,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
