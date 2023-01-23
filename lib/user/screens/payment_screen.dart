import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/car.dart';
import 'package:gac_car_rental/user/screens/home_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../configs/SizeConfig.dart';
import '../providers/user_provider.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = "/paymentScreen";

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var publicKey = 'pk_test_91b9f21f814a59e3877567f37a3aedd368a50eb9';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);

    super.initState();
  }

  //a method to show the message
  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //used to generate a unique reference for payment
  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  //async method to charge users card and return a response
  chargeCard(String email, int id, int amount, String days) async {
    var charge = Charge()
      ..amount = amount *
          100 //the money should be in kobo hence the need to multiply the value by 100
      ..reference = _getReference()
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email = email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    //check if the response is true or not
    if (response.status == true) {
      //you can send some data from the response to an API or use webhook to record the payment on a database
      // save
      Response? res =
          await RentCar(email: email, carID: id, amount: amount, days: days);
      if (res!.statusCode == 200) {
        _showMessage('Visit GAC to get you car, Check Bookings!');
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      _showMessage('Payment Failed!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<UserProvider>(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    int currentID = arguments['carID'];
    String days = arguments['days'];
    String total = arguments['total'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            child: CardsSwipe(),
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
                        'Make Payment',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () async {
                            chargeCard(user.loggedInUser['email'], currentID,
                                int.parse(total), days);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey, // Background color
                          ),
                          child: Text(
                            'Pay ${total} For ${days}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class CardsSwipe extends StatefulWidget {
  const CardsSwipe({Key? key}) : super(key: key);

  @override
  State<CardsSwipe> createState() => _CardsSwipeState();
}

class _CardsSwipeState extends State<CardsSwipe> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List cards = [
      Transform.scale(
        scale: 0.95,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => const DepositAmoountScreen()),
            // );
          },
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/card (1).png',
                fit: BoxFit.fill,
              )),
        ),
      ),
      Transform.scale(
        scale: 0.95,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => const DepositAmoountScreen()),
            // );
          },
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/card (2).png',
                fit: BoxFit.fill,
              )),
        ),
      ),
      Transform.scale(
        scale: 0.95,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => const DepositAmoountScreen()),
            // );
          },
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/card (3).png',
                fit: BoxFit.fill,
              )),
        ),
      ),
    ];
    return SizedBox(
      height: 200, // card height
      child: PageView.builder(
          itemCount: cards.length,
          controller: PageController(viewportFraction: 0.8),
          onPageChanged: (int index) => {setState(() => _index = index)},
          itemBuilder: (_, i) => cards[i]),
    );
  }
}
