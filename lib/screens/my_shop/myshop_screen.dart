import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopkee/screens/my_shop/components/add_product.dart';
import 'package:shopkee/constants.dart';

class MyShopScreen extends StatefulWidget {
  static String routeName = 'myshop_screen';

  const MyShopScreen({Key? key}) : super(key: key);

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  String? boss = FirebaseAuth.instance.currentUser?.email;
  String? imageUrl;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController detailCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  String? name, detail, price;

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      nameCtrl.text = documentSnapshot['name'];
      name = documentSnapshot['name'];
      detailCtrl.text = documentSnapshot['detail'];
      detail = documentSnapshot['detail'];
      priceCtrl.text = documentSnapshot['price'];
      price = documentSnapshot['price'];
    }
    await showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        documentSnapshot!['image'],
                        height: 180,
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
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.add_business),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          validator: (value) => ((value?.length ?? 0) < 10
                              ? 'At least 10 characters.'
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
                            labelText: 'Detail',
                            prefixIcon: Icon(Icons.library_books),
                            contentPadding: EdgeInsets.all(10),
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
                            labelText: 'Price',
                            prefixIcon: Icon(Icons.attach_money),
                            contentPadding: EdgeInsets.all(10),
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
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            if (name == nameCtrl.text &&
                                detail == detailCtrl.text &&
                                price == priceCtrl.text) {
                              EasyLoading.showError('Can\'t Update Product!');
                            } else if (name != null &&
                                detail != null &&
                                price != null) {
                              await _products.doc(documentSnapshot.id).update({
                                'name': nameCtrl.text,
                                'detail': detailCtrl.text,
                                'price': priceCtrl.text,
                              });
                              EasyLoading.showSuccess('Update Successful!');
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product.')));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            const Text(
              "MY SHOP",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              boss!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.routeName);
            },
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _products.orderBy('name', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                if (boss == documentSnapshot['boss']) {
                  return InkWell(
                    onTap: () {
                      _update(documentSnapshot);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Colors.black12,
                          )),
                      width: size.width - 2 * defaultPadding,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.network(
                              documentSnapshot['image'],
                            ),
                          ),
                          const SizedBox(
                            height: defaultPadding / 2,
                          ),
                          Text(
                            documentSnapshot['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: defaultPadding / 4,
                          ),
                          Text(
                            documentSnapshot['detail'],
                            maxLines: 2,
                            style: const TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 4),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 8,
                                        vertical: defaultPadding / 8),
                                    child: Text(
                                      documentSnapshot['price'] + '\$',
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 4,
                                        vertical: defaultPadding / 4),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: const Text(
                                      'FreeShip',
                                      style: TextStyle(color: Colors.white,fontSize: 18),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () =>
                                          _delete(documentSnapshot.id),
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ], // Text
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            );
          }
          return Container(
            margin: const EdgeInsets.only(
              left: 180,
            ),
            child: const CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        },
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
