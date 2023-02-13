import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/user_model.dart';

User? user = FirebaseAuth.instance.currentUser;
class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    Key? key,
    // this.imageUrl,
    this.press,
    this.image,
    // this.isMe,
  }) : super(key: key);
  String? image;
  VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<InfoUser?>(
      future: loadUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final InfoUser? infoUser = snapshot.data;
          if (image != null) {
            infoUser?.image = image;
          }
          return Column(
            children: [
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.14,
                      backgroundColor: Colors.grey[500]?.withOpacity(
                        0.5,
                      ),
                      child: (infoUser?.image != null)
                          ? CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundImage: NetworkImage(
                                (infoUser?.image)!,
                              ),
                            )
                          : Icon(
                              Icons.manage_accounts_outlined,
                              color: Colors.white,
                              size: size.width * 0.15,
                            ),
                    ),
                    Positioned(
                      top: size.height * 0.09,
                      left: size.width * 0.2,
                      child: Container(
                        width: size.width * 0.1,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.black)),
                        ),
                        child: IconButton(
                          onPressed: press,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // return const Center(
          //   child: CircularProgressIndicator(
          //     backgroundColor: Colors.lightBlueAccent,
          //   ),
          // );
          // final InfoUser? infoUser = snapshot.data;
          // if (image != null) {
          //   infoUser?.image = image;
          // }
          return Column(
            children: [
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.14,
                      backgroundColor: Colors.grey[500]?.withOpacity(
                        0.5,
                      ),
                      child: (image != null)
                          ? CircleAvatar(
                        radius: size.width * 0.14,
                        backgroundImage: NetworkImage(
                          (image)!,
                        ),
                      )
                          : Icon(
                        Icons.manage_accounts_outlined,
                        color: Colors.white,
                        size: size.width * 0.15,
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.09,
                      left: size.width * 0.2,
                      child: Container(
                        width: size.width * 0.1,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.black)),
                        ),
                        child: IconButton(
                          onPressed: press,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
