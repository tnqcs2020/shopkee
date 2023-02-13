import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopkee/components/product_card_small.dart';
import 'package:shopkee/constants.dart';

final _firestore = FirebaseFirestore.instance;

class ProductStreamAll extends StatefulWidget {
  const ProductStreamAll({Key? key,}) : super(key: key);
  @override
  State<ProductStreamAll> createState() => _ProductStreamAllState();
}

class _ProductStreamAllState extends State<ProductStreamAll> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').orderBy('name', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(left:180,),
            child: const CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final products = snapshot.data!.docs.reversed;
        List<ProductCardSmall> productCards = [];
        for (var product in products) {
          final productName = product.get('name');
          final productBoss = product.get('boss');
          final productDetail = product.get('detail');
          final productPrice = product.get('price');
          final productImage = product.get('image');
          final productCard = ProductCardSmall(
            name: productName,
            image: productImage,
            boss: productBoss,
            detail: productDetail,
            price: productPrice,
            press: () {},
          );
          productCards.add(productCard);
        }
        return Row(
          children: List.generate(
            productCards.length,
                (index) => Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: ProductCardSmall(
                name: productCards[index].name,
                image: productCards[index].image,
                detail: productCards[index].detail,
                boss: productCards[index].boss,
                price: productCards[index].price,
                press: () {},
              ),
            ),
          ),
        );
        // return productCards;
      },
    );
  }
}