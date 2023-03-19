import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopzmclay/vendors/controllers/vendor_register_controller.dart';


class VendorRegisterationScreen extends StatefulWidget {
  @override
  State<VendorRegisterationScreen> createState() =>
      _VendorRegisterationScreenState();
}

class _VendorRegisterationScreenState extends State<VendorRegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String businessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;

  late String countryValue;
  late String stateValue;
  late String cityValue;
  bool approved = false;

  Uint8List? _image;

  String? taxRegistered;
  List<String> _taxOptions = ['YES', 'NO'];

  _saveVendorDetail() async {
    EasyLoading.show(status: 'Please Wait!');
    if (_formKey.currentState!.validate()) {
      // EasyLoading.show(status: 'Please Wait!');
      // String resu = await _vendorController
       await _vendorController
          .registerVendor(
        businessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        taxRegistered!,
        taxNumber,
        _image,
        approved,
      )
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      });

      // showSnack(context, resu);

    } else {
      print('not good');
      // EasyLoading.dismiss();
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 200,
          flexibleSpace: LayoutBuilder(builder: (context, Constraints) {
            return FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.yellow.shade900, Colors.blue])),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: _image != null
                            ? InkWell(
                                onTap: () {
                                  selectGalleryImage();
                                },
                                child: Image.memory(_image!))
                            : IconButton(
                                onPressed: () {
                                  selectGalleryImage();
                                },
                                icon: Icon(CupertinoIcons.photo)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      businessName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Business Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Business name'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email Address must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email Address'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Tax Registered?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Container(
                          width: 100,
                          child: DropdownButtonFormField(
                              hint: Text('Select'),
                              items: _taxOptions.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  taxRegistered = value;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                  if (taxRegistered == 'YES')
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        onChanged: (value) {
                          taxNumber = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Tax Number must not be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(hintText: 'Tax No'),
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      _saveVendorDetail();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _auth.signOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Signout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
