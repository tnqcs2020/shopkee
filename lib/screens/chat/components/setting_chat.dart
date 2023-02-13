import 'package:flutter/material.dart';

class SettingChatScreen extends StatefulWidget {
  static const String routeName = 'setting_chat';
  const SettingChatScreen({Key? key}) : super(key: key);

  @override
  State<SettingChatScreen> createState() => _SettingChatScreenState();
}

class _SettingChatScreenState extends State<SettingChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
        centerTitle: true,
        title: const Text('Settings'),
        backgroundColor: Colors.white24,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'Settings',
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
