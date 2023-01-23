import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gac_car_rental/onboarding_screen.dart';
import 'package:gac_car_rental/user/screens/edit_profile.dart';
import 'package:gac_car_rental/user/screens/how_screen.dart';
import 'package:gac_car_rental/user/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import '../../widgets/alert_dialogue.dart';
import '../api/init.dart';
import '../configs/SizeConfig.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: user.loading
                        ? NetworkImage(
                            '${Init.urlInit}avatars/avatar.png',
                          )
                        : NetworkImage(
                            '${Init.urlInit}${user.loggedInUser['avatar']}',
                          ),
                  ),
                  title: Text(
                    user.loggedInUser['fullname'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    user.loggedInUser['phone'],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return EditScreen();
                  },
                ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    UniconsLine.edit,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  UniconsLine.history,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  'My History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    UniconsLine.cog,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'App Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HowToScreen();
                  },
                ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    UniconsLine.wrap_text,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'How it Works',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 30),
              child: OutlinedButton.icon(
                onPressed: () {
                  VoidCallback continueCallBack = () async {
                    // sign user out
                    final prefs = await SharedPreferences.getInstance();

                    final signOut = await prefs.remove('car-rental');

                    if (signOut) {
                      Navigator.of(context)
                          .pushReplacementNamed(OnBoardingScreen.routeName);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardingScreen()),
                        (route) => false,
                      );
                    }
                  };
                  BlurryDialog alert = BlurryDialog("Sign Out",
                      "Are you sure you want to Sign Out? ", continueCallBack);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                icon: Icon(
                  UniconsLine.signout,
                  size: 24,
                  color: Colors.white,
                ),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).errorColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
