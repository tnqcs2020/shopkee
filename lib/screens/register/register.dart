import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopkee/components/user_model.dart';
import 'package:shopkee/screens/profile/components/profile_picture.dart';
import 'package:shopkee/screens/start.dart';
import 'package:shopkee/screens/login/login.dart';
import 'package:shopkee/screens/home.dart';

late UserCredential newUser;

class RegisterScreen extends StatefulWidget {
  static String routeName = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final repassCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  String? imageUrl;

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
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, StartScreen.routeName);
              },
              icon: const Icon(Icons.home),
            ),
            title: Column(
              children: const [
                Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: const Text(
                  ' Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const Text(
                    'All information is required',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (imageUrl == null)
                      ? ProfilePicture(
                          press: uploadImage,
                        )
                      : ProfilePicture(
                          image: imageUrl,
                          press: uploadImage,
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
                    Container(
                      height: 30,
                      padding: const EdgeInsets.only(right: 200),
                      child: const Text(
                        'Login information:',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your email.',
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) =>
                          ((value?.length ?? 0) == 0 ? 'Do not empty.' : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your\'s password.',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) < 6
                          ? 'At least 6 characters.'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: repassCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your\'s password.',
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value ?? 0) != passCtrl.text
                          ? 'Password does not match.'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      padding: const EdgeInsets.only(right: 200),
                      child: const Text(
                        'Other information:',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your name.',
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      controller: phoneCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your phone number.',
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) != 10
                          ? 'Includes 10 numbers'
                          : null),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: addressCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your address.',
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) => ((value?.length ?? 0) < 6
                          ? 'At least 6 characters.'
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
            padding: const EdgeInsets.fromLTRB(140, 20, 140, 20),
            sliver: SliverToBoxAdapter(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final FormState? form = _formKey.currentState;
                  if (form!.validate()) {
                    try {
                      newUser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailCtrl.text, password: passCtrl.text);
                      if (newUser != null) {
                        EasyLoading.showSuccess('Register Successful!');
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        EasyLoading.showError('Can\'t Register Account!');
                      }
                    } catch (e) {
                      print(e);
                    }
                    final infoUser = InfoUser(
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      phone: phoneCtrl.text,
                      address: addressCtrl.text,
                      image: imageUrl!,
                      id: newUser.user!.uid,
                    );
                    createUser(infoUser);
                  } else {
                    EasyLoading.showError('Can\'t Register Account!');
                  }
                },
                child: const Text(
                  'Register',
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
      print("Permission not granted. Try again with permission access");
    }
  }
}
