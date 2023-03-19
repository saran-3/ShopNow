import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/product_provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  List<File> _image = [];

  final List<String> _imageUrlList = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No Image selected');
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        GridView.builder(
            shrinkWrap: true,
            itemCount: _image.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 3 / 3),
            itemBuilder: ((context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                          onPressed: () {
                            chooseImage();
                          },
                          icon: Icon(Icons.add)),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index - 1]))),
                    );
            })),
        TextButton(
          onPressed: () async {
            EasyLoading.show(status: 'Saving Image');
            for (var img in _image) {
              Reference ref =
                  _storage.ref().child('productImage').child(Uuid().v4());
              await ref.putFile(img).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  setState(() {
                    _imageUrlList.add(value);
                    
                  });
                });
              });
            }
            setState(() {
              _productProvider.getFormData(imageUrlList: _imageUrlList);
                    EasyLoading.dismiss(); 
            });
           
          },
          child: _image.isNotEmpty ? Text('Upload') : Text(''),
        ),
      ]),
    );
  }
}
