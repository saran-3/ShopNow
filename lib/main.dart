import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/cart_provider.dart';
import 'package:shopzmclay/provider/product_provider.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
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
      // home: MainVendorScreen(),
      // home: BuyersRegisterScreen(),
      // home: MainScreen(),
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}

/*flutter pub global run rename --bundleId com.codearts.shappy.app --target android


C:\Program Files\Android\Android Studio4\jre\bin\java


keytool -genkey -v -keystore C:\Users\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upl


 */