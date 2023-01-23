import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/car.dart';
import 'package:gac_car_rental/user/api/init.dart';
import 'package:gac_car_rental/user/api/user.dart';
import 'package:gac_car_rental/user/configs/SizeConfig.dart';
import 'package:gac_car_rental/user/providers/car_user_provider.dart';
import 'package:gac_car_rental/user/providers/user_provider.dart';
import 'package:gac_car_rental/user/screens/bookings_screen.dart';
import 'package:gac_car_rental/user/screens/car_detail_screen.dart';
import 'package:gac_car_rental/user/screens/profile_screen.dart';
import 'package:gac_car_rental/user/screens/search_screen.dart';
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final List<Widget> _pages = [Home(), BookingsScreen(), ProfileScreen()];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(UniconsLine.car),
        title: Text(
          'GAC Car Rental',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: user.loading
                  ? NetworkImage(
                      '${Init.urlInit}avatars/avatar.png',
                    )
                  : NetworkImage(
                      '${Init.urlInit}${user.loggedInUser['avatar']}',
                    ),
            ),
          ),
        ],
      ),
      body: _pages[currentPage],
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: Colors.deepPurple,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
    );
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: UniconsLine.home,
      iconSize: 25.0,
      title: 'Home',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.car_rental,
      iconSize: 25,
      title: 'Bookings',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.person_outline,
      iconSize: 25,
      title: 'Profile',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ];
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;

  @override
  void initState() {
    getAllBrands();
    getAllTheCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        color: Color(0xFFE3E3E3),
        child: Column(
          children: [
            Column(children: [
              Container(
                width: double.infinity,
                height: SizeConfig.blockSizeVertical * 25,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/cover.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'GAC MOTORS',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextButton.icon(
                                icon: Icon(
                                  UniconsLine.history,
                                  color: Colors.deepPurple,
                                ),
                                label: Text('My History'),
                                onPressed: () {
                                  //
                                },
                              ),
                            ]),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Car Brands',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            child: Text('View All'),
                            onPressed: () {
                              //
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: getAllBrands(),
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
                        child: Text('No Brands'),
                      );
                    }

                    return snapshot.hasData
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Row(
                              children:
                                  List.generate(snapshot.data['size'], (index) {
                                String curBrand =
                                    "${Init.urlInit}brands/${snapshot.data['data'][index]['logo']}";

                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(curBrand),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                        : CircularProgressIndicator();
                  }),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available Cars',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            Expanded(
              child: FutureBuilder(
                  future: getAllTheCars(),
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
                        child: Text('No Brands'),
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
                                    child: Stack(children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CarDetailScreen.routeName,
                                              arguments: {
                                                'carID': snapshot.data['data']
                                                    [index]['id']
                                              });
                                        },
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        Icon(
                                                          Icons.star_outline,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                      ],
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
                                                                  EdgeInsets
                                                                      .all(3),
                                                              backgroundColor:
                                                                  Colors
                                                                      .deepPurple,
                                                              label: Text(
                                                                "N${snapshot.data['data'][index]['price']}/day",
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
                                      Positioned(
                                        top: 5,
                                        left: 5,
                                        child: Container(
                                            color: Colors.deepPurple,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot.data['data'][index]
                                                    ['bname'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ]),
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
