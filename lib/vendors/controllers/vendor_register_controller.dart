
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FUNCTION TO IMAGE IN FIREBASE STORAGE

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImages').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

// FUNCTION TO IMAGE IN FIREBASE STORAGE IS ENDS HERE

// ==============================================

// FUNCTION TO PICK STORE IMAGE

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print("No image selected");
    }
  }

// FUNCTION TO PICK STORE IMAGE IS ENDS HERE

// ==============================================

// FUNCTION TO STORE VENDOR DATA

  Future<String> registerVendor(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
    bool approved,
  ) async {
    String res = 'some error occured';
    try {
      // SAVE DATA TO CLOUD FIRESTORE
// UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);

      // UserCredential cred = await _auth.createUserWithEmailAndPassword(
      //     email: emailAddress, password: businessName);

      String storeImage = await _uploadVendorImageToStorage(image);
      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        // await _firestore.collection('vendors').doc(cred.user!.uid).set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': storeImage,
        'approved': approved,
        'vendorId': _auth.currentUser!.uid,
      });
      // showSnack(context, res);
    } catch (e) {
      res = e.toString();
      // print(res);
      //  showSnack(context, res);
    }
    // print(res);
    return res;
  }
}
// FUNCTION TO STORE VENDOR DATA ENDS HERE
// ==============================================
