import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopkee/components/user_model.dart';
import 'package:shopkee/screens/profile/components/profile_menu.dart';
import 'package:shopkee/screens/profile/screens/notification.dart';
import 'package:shopkee/screens/profile/components/profile_picture.dart';
import 'package:shopkee/screens/profile/screens/setting.dart';
import 'package:shopkee/screens/profile/screens/help_center.dart';
import 'package:shopkee/screens/profile/screens/my_account/my_account.dart';
import 'package:shopkee/screens/start.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'account';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('PROFILE'),
        backgroundColor: Colors.white24,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      body: Column(
        children: [
          ProfilePicture(image: imageUrl,press: uploadImage),
          const SizedBox(height: 20.0),
          ProfileMenu(
            icon: Icons.manage_accounts_outlined,
            text: 'My Account',
            press: () {
              Navigator.pushNamed(context, MyAccountScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: Icons.notifications,
            text: 'Notifications',
            press: () {
              Navigator.pushNamed(context, NotificationScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: Icons.settings_outlined,
            text: 'Settings',
            press: () {
              Navigator.pushNamed(context, SettingScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: Icons.help_center_outlined,
            text: 'Help Center',
            press: () {
              Navigator.pushNamed(context, HelpCenterScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: Icons.logout_outlined,
            text: 'Log Out',
            press: () {
              _auth.signOut();
              Navigator.pushNamed(context, StartScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  reloadImage() async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'image': imageUrl!,
    });
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
        reloadImage();
      } else {
        print('No image path received');
      }
    } else {
      print('Permission not granted. Try again with permission access');
    }
  }
}
