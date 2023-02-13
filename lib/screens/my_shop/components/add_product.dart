import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopkee/screens/profile/components/profile_picture.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class AddProduct extends StatefulWidget {
  static String routeName = 'addproduct_screen';

  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final detailCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  String? imageUrl;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('User: $user');
      }
    } catch (e) {
      print(e);
    }
  }

  void Add() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      _firestore.collection('products').add({
        'image': imageUrl,
        'name': nameCtrl.text,
        'boss': loggedInUser.email,
        'detail': detailCtrl.text,
        'price': priceCtrl.text,
        'id': user!.uid,
      });
      EasyLoading.showSuccess('Add Successful!');
      Navigator.pop(context);
    } else {
      EasyLoading.showError('Can\'t Add Product!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            floating: true,
            leading: const BackButton(
              color: Colors.black,
            ),
            title: Column(
              children: const [
                Text(
                  "Add New Product",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(120, 20, 120, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  (imageUrl != null)
                      ? Image.network(imageUrl!)
                      : const Placeholder(
                          fallbackWidth: 130,
                          fallbackHeight: 170,
                        ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      uploadImage();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Product\'s name',
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.add_business),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) < 9
                          ? 'At least 9 characters.'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: detailCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Product\'s detail',
                        labelText: 'Detail',
                        prefixIcon: Icon(Icons.library_books),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) == 0
                          ? 'Detail is not empty.'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: priceCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Units are dollars.',
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) < 1
                          ? 'At least 1 number.'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(160, 20, 160, 20),
            sliver: SliverToBoxAdapter(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Add();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadImage() async {
    final imagePicker = ImagePicker();
    PickedFile? image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);
      if (image != null) {
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('images/${image.path.split('/').last}')
            .putFile(file)
            .whenComplete(() => null);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No image path received');
      }
    } else {
      print('Permission not granted. Try again with permission access');
    }
  }
}
