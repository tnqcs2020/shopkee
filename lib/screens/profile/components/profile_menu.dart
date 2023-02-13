import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: MaterialButton(
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color(0xfff5f6f9),
            onPressed: press,
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    child: Text(
                  text,
                )),
                const Icon(Icons.arrow_forward_ios_outlined),
              ],
            )));
  }
}
