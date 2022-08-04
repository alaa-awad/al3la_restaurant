import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getOrders();
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
              body: ListView.separated(
                  itemBuilder: (context, index) => itemOrder(
                      context, HomeCubit.get(context).allOrders[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: HomeCubit.get(context).allOrders.length));
        });
  }
}

Widget itemOrder(BuildContext context, CartModule cartModule) {
/* cartModule.orders.forEach((key, value) {
   print("$key : $value");
 });*/
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(cartModule.nameTablet)),
        const SizedBox(
          height: 10,
        ),
        Center(child: Text(cartModule.dateTime)),
        const SizedBox(
          height: 15,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemBuilder: (context, index){
            String nameMeal = cartModule.orders.keys.elementAt(index);
              int countMeal = cartModule.orders.values.elementAt(index);
             return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$nameMeal  :  $countMeal"),
                ],
              );
            },
        itemCount: cartModule.orders.length,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
