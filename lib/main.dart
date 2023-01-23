import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gac_car_rental/admin/providers/count_provider.dart';
import 'package:gac_car_rental/admin/screens/add_brand_screen.dart';
import 'package:gac_car_rental/admin/screens/add_car_screen.dart';
import 'package:gac_car_rental/admin/screens/admin_code_screen.dart';
import 'package:gac_car_rental/admin/screens/admin_homepage_screen.dart';
import 'package:gac_car_rental/admin/screens/admin_login_screen.dart';
import 'package:gac_car_rental/admin/screens/brands_screen.dart';
import 'package:gac_car_rental/admin/screens/cars_screen.dart';
import 'package:gac_car_rental/onboarding_screen.dart';
import 'package:gac_car_rental/splash_screen.dart';
import 'package:gac_car_rental/user/providers/car_user_provider.dart';
import 'package:gac_car_rental/user/providers/user_provider.dart';
import 'package:gac_car_rental/user/screens/car_booking_datetime.dart';
import 'package:gac_car_rental/user/screens/car_detail_screen.dart';
import 'package:gac_car_rental/user/screens/home_screen.dart';
import 'package:gac_car_rental/user/screens/payment_screen.dart';
import 'package:gac_car_rental/user/screens/sign_in_screen.dart';
import 'package:gac_car_rental/user/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import 'admin/providers/car_provider.dart';

void main(List<String> args) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(GACAPP());
}

class GACAPP extends StatefulWidget {
  const GACAPP({super.key});

  @override
  State<GACAPP> createState() => _GACAPPState();
}

class _GACAPPState extends State<GACAPP> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CountProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarUserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        title: "GAC Car Rental",
        home: GACSplashScreen(),
        routes: {
          // App
          OnBoardingScreen.routeName: (ctx) => const OnBoardingScreen(),
          SignInScreen.routeName: (ctx) => const SignInScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),

          // admin
          AdminCodeScreen.routeName: (ctx) => const AdminCodeScreen(),
          AdminLoginScreen.routeName: (ctx) => const AdminLoginScreen(),
          AdminHomePageScreen.routeName: (ctx) => const AdminHomePageScreen(),
          AddBrandScreen.routeName: (ctx) => const AddBrandScreen(),
          BrandsScreen.routeName: (ctx) => const BrandsScreen(),
          AddCarScreen.routeName: (ctx) => const AddCarScreen(),
          CarsScreen.routeName: (ctx) => const CarsScreen(),

          // User
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          CarDetailScreen.routeName: (ctx) => const CarDetailScreen(),
          CarBookingDateTime.routeName: (ctx) => const CarBookingDateTime(),
          PaymentScreen.routeName: (ctx) => const PaymentScreen(),
        },
      ),
    );
  }
}
