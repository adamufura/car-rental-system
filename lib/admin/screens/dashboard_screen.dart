import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/add_brand_screen.dart';
import 'package:gac_car_rental/admin/screens/add_car_screen.dart';
import 'package:gac_car_rental/admin/widgets/logout.dart';
import 'package:provider/provider.dart';

import '../api/init.dart';
import '../providers/count_provider.dart';
import 'admin_homepage_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<CountProvider>(context, listen: false).getBrandCount('brands');
    Provider.of<CountProvider>(context, listen: false).getCarCount('cars');
    Provider.of<CountProvider>(context, listen: false).getRentCount('rents');
    Provider.of<CountProvider>(context, listen: false).getUserCount('users');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final counts = Provider.of<CountProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        leading: DrawerWidget(),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 3,
            child: ListTile(
              title: Text(
                'Welcome Admin',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              trailing: Image.network(
                '${Init.urlInit}avatars/admin.png',
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.count(crossAxisCount: 2, children: [
                Card(
                  elevation: 5,
                  child: GridTile(
                    header: Container(
                      color: Colors.deepPurple,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'BRANDS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.branding_watermark_outlined,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          '${counts.loading ? '0' : counts.getBrandsCount} Brands',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    footer: Container(
                        color: Colors.deepPurple,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AddBrandScreen.routeName),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add Brand',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: GridTile(
                    header: Container(
                      color: Colors.deepPurple,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'CARS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.car_crash,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          '${counts.loading ? '0' : counts.getCarsCount} CARS',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    footer: Container(
                        color: Colors.deepPurple,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AddCarScreen.routeName),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add a Car',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: GridTile(
                    header: Container(
                      color: Colors.deepPurple,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Car Rents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.car_rental_outlined,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          '${counts.loading ? '0' : counts.getRentsCount} Rents',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    footer: Container(
                        color: Colors.deepPurple,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.view_agenda_outlined,
                            color: Colors.white,
                          ),
                          label: Text(
                            'View Rents',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: GridTile(
                    header: Container(
                      color: Colors.deepPurple,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Users',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          '${counts.loading ? '0' : counts.getUsersCount} Users',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    footer: Container(
                        color: Colors.deepPurple,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.view_agenda_outlined,
                            color: Colors.white,
                          ),
                          label: Text(
                            'View Users',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
