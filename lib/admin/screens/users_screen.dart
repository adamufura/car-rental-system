import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gac_car_rental/admin/api/user.dart';
import 'package:http/http.dart';

import '../api/init.dart';
import '../widgets/logout.dart';
import 'admin_homepage_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
        leading: DrawerWidget(),
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: FutureBuilder(
        future: getAllUsers(),
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
              child: Text('No Users found.'),
            );
          }

          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data['size'],
                  itemBuilder: (context, index) {
                    List data = snapshot.data['data'];
                    int counter = index + 1;
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            child: Text(
                          counter.toString(),
                        )),
                        title: Text(data[index]['fullname']),
                        subtitle: Text(data[index]['email']),
                        trailing: Image.network(
                          Init.urlInit +
                              "" +
                              data[index]['avatar'].toString().trim(),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
