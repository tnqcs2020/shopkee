import 'package:flutter/material.dart';
import 'package:shopkee/components/product_stream_all.dart';
import 'package:shopkee/constants.dart';
import 'package:shopkee/screens/homepage/components/image_carousel.dart';
import 'package:shopkee/screens/homepage/components/section_title.dart';

class HomePageScreen extends StatelessWidget {
  static const String routeName = 'homepage';
  const HomePageScreen({Key? key}) : super(key: key);
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
            leading: TextButton(
              onPressed: () {},
              child: const Icon(Icons.menu, color: Colors.black),
            ),
            title: Column(
              children: const [
                Text(
                  "SHOPKEE",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: ImageCarousel(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SectionTitle(
                title: 'All Product',
                press: () {},
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ProductStreamAll(),
            ),
          ),
        ],
      ),
    );
  }
}
