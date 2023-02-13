import 'package:flutter/material.dart';
import 'package:shopkee/constants.dart';

// String? text;
// class SetTextField extends StatelessWidget {
//   const SetTextField({
//     Key? key,
//     required this.icon,
//     required this.hint,
//     required this.inputType,
//     required this.inputAction,
//   }) : super(key: key);
//   final IconData icon;
//   final String hint;
//   final TextInputType inputType;
//   final TextInputAction inputAction;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//         height: size.height * 0.08,
//         width: size.width * 0.8,
//         decoration: BoxDecoration(
//           color: Colors.grey[500]?.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Center(
//           child: TextField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Icon(
//                   icon,
//                   size: 28,
//                   color: Colors.white,
//                 ),
//               ),
//               hintText: hint,
//               hintStyle: const TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
//             ),
//             style: const TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
//             keyboardType: inputType,
//             textInputAction: inputAction,
//             onChanged: (value) {
//               text = value;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// String getTextField(){
//   return text!;
// }