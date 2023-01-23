import 'package:flutter/material.dart';

import '../configs/SizeConfig.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Middle Name')),
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Last Name')),
                  TextFormField(
                      decoration: const InputDecoration(labelText: 'Email')),
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Date Of Birth')),
                  TextFormField(
                      decoration: const InputDecoration(labelText: 'Gender')),
                ],
              ),
            ),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: SizeConfig.safeBlockHorizontal * 70,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  // Navigator.of(context).pushNamed(InsurerHomeScreen.routeName);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      Icon(Icons.check, color: Colors.white)
                    ]),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: BorderSide(
                      width: 1.5, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
