import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopzmclay/controllers/auth_controller.dart';
import 'package:shopzmclay/utils/show_snackbar.dart';
import 'package:shopzmclay/views/buyers/auth/login_screen.dart';

class BuyersRegisterScreen extends StatefulWidget {
  @override
  State<BuyersRegisterScreen> createState() => _BuyersRegisterScreenState();
}

class _BuyersRegisterScreenState extends State<BuyersRegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  late String address;

  bool _isLoading = false;
  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.SignUpUser(
              email, fullName, phoneNumber, password, _image, address)
          .whenComplete(() {
        setState(() {
          _isLoading = false;
          _formKey.currentState!.reset();
        });
        showSnack(
            context, 'Congatulation, An Account has been created for You!');
      }
      
      );

      // showSnack(context, 'Error, Try Again!');
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnack(context, 'Please, Fields must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List _im = await _authController.pickProfileImage(ImageSource.gallery);
    _image = _im;
  }

  // selectCameraImage() async {
  //   Uint8List _im = await _authController.pickProfileImage(ImageSource.camera);
  //   _image = _im;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Customer' + "'" + 's Account',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: NetworkImage(
                              'https://www.shutterstock.com/image-vector/default-avatar-profile-vector-user-260nw-1705357234.jpg')),
                  Positioned(
                      // right: 5,
                      top: 40,
                      left: 40,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(CupertinoIcons.photo),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    autofillHints: [AutofillHints.email],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please email must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(hintText: 'Enter your email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    autofillHints: [AutofillHints.name],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(hintText: 'Enter fullname'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    autofillHints: [AutofillHints.telephoneNumber],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(hintText: 'Enter phone number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    autofillHints: [AutofillHints.addressCity],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Address must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      address = value;
                    },
                    decoration: InputDecoration(hintText: 'Enter Address'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    autofillHints: [AutofillHints.password],
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(hintText: 'Enter password'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
