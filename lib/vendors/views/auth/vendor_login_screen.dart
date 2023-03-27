import 'package:flutter/material.dart';
import 'package:shopzmclay/controllers/auth_controller.dart';
import 'package:shopzmclay/utils/show_snackbar.dart';
import 'package:shopzmclay/vendors/screens/earnings_screen.dart';
import 'package:shopzmclay/vendors/views/auth/vendor_register_screen.dart';
import 'package:shopzmclay/views/buyers/auth/register_screen.dart';
import 'package:shopzmclay/views/buyers/main_screen.dart';
import 'package:shopzmclay/views/buyers/nav_screens/home_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;

  late String password;
  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.loginUsers(email, password);
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return EarningsScreen();
          },
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnack(context, 'Please, Fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Login to Customer"s Account',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Email field must not be empty';
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
                  autofillHints: [AutofillHints.password],
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Password field must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(hintText: 'Enter Password'),
                ),
              ),
              InkWell(
                onTap: () {
                  _loginUsers();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5),
                            ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return VendorRegisterationScreen();
                      }));
                    },
                    child: Text('Sign up'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
