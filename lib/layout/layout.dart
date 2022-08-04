
import 'package:al3la_restaurant/modules/restaurant_page/restaurant_page.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RestaurantPage(),
      //tabletModel!= null?const RestaurantPage():const CategoriesPage(),
    );
  }
}
