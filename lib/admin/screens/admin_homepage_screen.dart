import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gac_car_rental/admin/screens/brands_screen.dart';
import 'package:gac_car_rental/admin/screens/cars_screen.dart';
import 'package:gac_car_rental/admin/screens/dashboard_screen.dart';
import 'package:gac_car_rental/admin/screens/rents_screen.dart';
import 'package:gac_car_rental/admin/screens/settings_screen.dart';
import 'package:gac_car_rental/admin/screens/users_screen.dart';

class AdminHomePageScreen extends StatefulWidget {
  static const routeName = "/adminHomePageScreen";
  const AdminHomePageScreen({super.key});

  @override
  State<AdminHomePageScreen> createState() => _AdminHomePageScreenState();
}

class _AdminHomePageScreenState extends State<AdminHomePageScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(
        setIndex: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      mainScreen: currentScreen(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      slideWidth: 200,
      menuBackgroundColor: Colors.deepPurple,
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return BrandsScreen();
      case 2:
        return CarsScreen();
      case 3:
        return RentsScreen();
      case 4:
        return UsersScreen();
      case 5:
        return SettingsScreen();
      default:
        return DashboardScreen();
    }
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drawerList(Icons.space_dashboard_outlined, "Dashboard", 0),
          drawerList(Icons.branding_watermark_outlined, "Brands", 1),
          drawerList(Icons.car_crash, "Cars", 2),
          drawerList(Icons.car_rental_outlined, "Rents", 3),
          drawerList(Icons.people_alt_outlined, "Users", 4),
          drawerList(Icons.settings, "Settings", 5),
        ],
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: Icon(Icons.menu),
    );
  }
}
