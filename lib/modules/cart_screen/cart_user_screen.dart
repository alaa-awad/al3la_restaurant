import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/cart.dart';
import 'package:al3la_restaurant/modules/check_user/check_password_screen.dart';
import 'package:al3la_restaurant/modules/check_user/logIn_worker.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).orders.forEach((element) {
      totalPrice += int.parse(element.meal.price) * element.count;
    });
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddCartSuccessStates) {
          navigateAndFinish(context,LogInWorkersScreen());
          showToast(
              text:
                  getTranslated(context, "CheckPassword_Screen_success_order"),
              state: ToastStates.success);
        }
        if (state is AddCartErrorStates) {
          isLoading = false;
          showToast(text: state.error, state: ToastStates.error);
        }
        if (state is AddCartLoadingStates) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return HomeCubit.get(context).orders.isEmpty
            ? Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text(getTranslated(
                      context, 'Cart_Page_Total_Order_isEmpty_key')),
                ),
              )
            : Scaffold(
                appBar: AppBar(),
                body: isLoading == false
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                //  shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return itemOrder(context,
                                      HomeCubit.get(context).orders[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 15,
                                  );
                                },
                                itemCount:
                                    HomeCubit.get(context).orders.length),
                          ),
                          //const Spacer(),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: defaultColor,
                                  width: double.infinity,
                                  height: 3,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    getTranslated(context,
                                        'Cart_Page_Total_price_Order_key'),
                                    style: const TextStyle(
                                        color: defaultColor, fontSize: 17),
                                  ),
                                  Text(
                                    '$totalPrice\$',
                                    style: const TextStyle(
                                        color: defaultColor, fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: (state is! ChangeCountOrderMeal)
                                ? orderDone == false
                                    ? AdaptiveButton(
                                        os: getOs(),
                                        background: defaultColor,
                                        function: () {
                                          HomeCubit.get(context).addCart(
                                              totalPrice: totalPrice,
                                              nameTable: tableNumber);
                                        },
                                        text: getTranslated(
                                            context, 'Cart_Page_Add_Order_key'),
                                        isUpperCase: true,
                                      )
                                    : AdaptiveButton(
                                        os: getOs(),
                                        background: defaultColor,
                                        function: () {
                                          navigateTo(
                                              context, CheckPasswordScreen());
                                        },
                                        text: getTranslated(context,
                                            'Cart_Page_Update_Order_key'),
                                        isUpperCase: true,
                                      )
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Center(
                        child: AdaptiveIndicator(
                          os: getOs(),
                        ),
                      ),
              );
      },
    );
  }

  Widget itemOrder(BuildContext context, OrderModule orderModule) {
    dynamic price = orderModule.count * int.parse(orderModule.meal.price);
    return InkWell(
      onTap: () {
        ///ToDo: if you want update order
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(orderModule.meal.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    orderModule.meal.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'العدد ${orderModule.count}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: kTextColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                '$price\$',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
