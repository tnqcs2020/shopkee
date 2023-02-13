import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopkee/screens/profile/screens/help_center.dart';
import 'package:shopkee/screens/homepage/homepage.dart';
import 'package:shopkee/screens/profile/screens/my_account/my_account.dart';
import 'package:shopkee/screens/my_shop/components/add_product.dart';
import 'package:shopkee/screens/my_shop/myshop_screen.dart';
import 'package:shopkee/screens/profile/screens/notification.dart';
import 'package:shopkee/screens/profile/profile.dart';
import 'package:shopkee/screens/login/login.dart';
import 'package:shopkee/screens/register/register.dart';
import 'package:shopkee/screens/profile/screens/setting.dart';
import 'package:shopkee/screens/chat/components/setting_chat.dart';
import 'package:shopkee/screens/start.dart';
import 'package:shopkee/screens/chat/chat.dart';
import 'package:shopkee/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MessengerFake());
}

class MessengerFake extends StatelessWidget {
  const MessengerFake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => const StartScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ChatScreen.routeName: (context) => const ChatScreen(),
        MyShopScreen.routeName: (context) => const MyShopScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        MyAccountScreen.routeName: (context) => const MyAccountScreen(),
        HomePageScreen.routeName: (context) => const HomePageScreen(),
        SettingScreen.routeName: (context) => const SettingScreen(),
        NotificationScreen.routeName: (context) => const NotificationScreen(),
        HelpCenterScreen.routeName: (context) => const HelpCenterScreen(),
        SettingChatScreen.routeName: (context) => const SettingChatScreen(),
        AddProduct.routeName: (context) => const AddProduct(),
      },
      builder: EasyLoading.init(),
    );
  }
}
