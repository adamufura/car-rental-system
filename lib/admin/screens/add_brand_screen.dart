import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/api/brand.dart';
import 'package:image_picker/image_picker.dart';

import '../configs/SizeConfig.dart';

class AddBrandScreen extends StatefulWidget {
  static const routeName = "/addBrandScreen";
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  File _pickedImage = File('');
  late final ImagePicker _imagePicker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  Future choiceImage() async {
    final _imageFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 300,
      maxHeight: 300,
    );
    setState(() {
      if (_imageFile != null) {
        _pickedImage = File(_imageFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Car Brand')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              OutlinedButton.icon(
                onPressed: () => choiceImage(),
                icon: Icon(Icons.camera),
                label: Text('Add Brand Logo'),
              ),
              Container(
                width: double.infinity,
                height: SizeConfig.blockSizeVertical * 30,
                child: _pickedImage.path.isNotEmpty
                    ? Card(
                        elevation: 3,
                        child: Image.file(_pickedImage),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Logo Selected',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'Brand Name',
                  labelText: 'Enter Brand Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Add Brand'),
                  onPressed: () async {
                    await AddBrand(
                      name: nameController.text.trim(),
                      logoFile: _pickedImage,
                      context: context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
