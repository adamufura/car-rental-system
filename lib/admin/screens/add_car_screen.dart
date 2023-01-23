import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/api/car.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../configs/SizeConfig.dart';
import '../providers/car_provider.dart';

class AddCarScreen extends StatefulWidget {
  static const routeName = "/addCarScreen";

  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  File _pickedImage = File('');
  late final ImagePicker _imagePicker = ImagePicker();

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

  // Brands

  List<Map<dynamic, dynamic>> items = [];
  List tempList = [];

  @override
  void initState() {
    Provider.of<CarProvider>(context, listen: false).getAllCarBrand();
    super.initState();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var brandSelectedValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final brands = Provider.of<CarProvider>(context);

    if (brands.loading) {
      print("loading...");
    } else {
      print('done loading');
      tempList.add(brands.getBrands['data']);

      tempList.forEach((element) {
        element.forEach((el) {
          Map map = {"id": el[0], "name": el[1]};

          brandSelectedValue = map;
          items.add(map);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add New Car')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: () => choiceImage(),
                  icon: Icon(Icons.camera),
                  label: Text('Add Car Logo'),
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
                            'No Car Image Selected',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Car Name',
                    labelText: 'Enter Car Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Select a Brand',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map(
                              (item) => DropdownMenuItem<Map<dynamic, dynamic>>(
                                    value: item,
                                    child: Text(
                                      item['name'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                          .toList(),
                      value: brandSelectedValue,
                      onChanged: (value) {
                        setState(() {
                          brandSelectedValue = value;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 200,
                      itemHeight: 40,
                      dropdownMaxHeight: 200,
                      searchController: brandController,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: brandController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value.toString().contains(searchValue));
                      },
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          brandController.clear();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Rent Price Per day',
                    labelText: 'Enter Rent Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: powerController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Speed',
                    labelText: 'Enter Car Speed',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: typeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Type',
                    labelText: 'Enter Car Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: fuelController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Fuel',
                    labelText: 'Enter Car Fuel',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: seatsController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Seats',
                    labelText: 'Enter Car Seats',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: detailsController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 50,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Car Details',
                    labelText: 'Enter Car Details',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Add Car'),
                    onPressed: () async {
                      await AddCar(
                        imageFile: _pickedImage,
                        name: nameController.text.trim(),
                        brand: brandSelectedValue['id'].toString(),
                        price: priceController.text.trim(),
                        power: powerController.text.trim(),
                        type: typeController.text.trim(),
                        fuel: fuelController.text.trim(),
                        seats: seatsController.text.trim(),
                        details: detailsController.text.trim(),
                        context: context,
                      );
                      setState(() {
                        _formkey.currentState!.reset();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
