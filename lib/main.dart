import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/cart_provider.dart';
import 'package:shopzmclay/provider/product_provider.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/vendors/views/auth/vendor_auth.dart';
import 'package:shopzmclay/views/buyers/auth/login_screen.dart';
import 'package:shopzmclay/views/buyers/auth/register_screen.dart';
import 'package:shopzmclay/views/buyers/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Brand-Bold",
        primarySwatch: Colors.blue,
      ),

      home: AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopify_sharp),
              Text(
                ('ShopNow'),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue,
          nextScreen: MainScreen(),
          duration: 3000),

      // home: MainVendorScreen(),
      // home: BuyersRegisterScreen(),
      // home: MainScreen(),
      // home: VendorAuthScreen(),
      // home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}

/*flutter pub global run rename --bundleId com.codearts.shappy.app --target android


C:\Program Files\Android\Android Studio4\jre\bin\java


keytool -genkey -v -keystore C:\Users\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upl


 */