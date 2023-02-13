import 'package:flutter/material.dart';
import 'package:shopkee/constants.dart';

class ProductCardSmall extends StatelessWidget {
  const ProductCardSmall({
    Key? key,
    required this.name,
    required this.image,
    required this.detail,
    required this.press,
    required this.boss,
    required this.price,
  }) : super(key: key);
  final String name, image, boss, detail, price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            border: Border.all(
              color: Colors.black12,
            )),
        width: 200,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Image.network(image),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: defaultPadding / 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 8, vertical: defaultPadding / 8),
              decoration: const BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Text(
                boss,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: defaultPadding / 4,
            ),
            Text(
              detail,
              maxLines: 2,
              style: const TextStyle(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.black, fontSize: 12),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding/8,
                          vertical: defaultPadding / 8),
                      child: Text(
                        '$price\$',
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    const CircleAvatar(radius: 2,backgroundColor: Colors.grey,),
                    const SizedBox(width: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 8,
                          vertical: defaultPadding / 8),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Text(
                        'FreeShip',
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ], // Text
        ),
      ),
    );
  }
}
