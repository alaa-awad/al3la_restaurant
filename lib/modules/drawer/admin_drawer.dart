import 'package:al3la_restaurant/modules/cart_screen/orders_screen.dart';
import 'package:al3la_restaurant/modules/qr_screen/qr_screen.dart';
import 'package:al3la_restaurant/modules/restaurant_information/restaurant_information.dart';
import 'package:al3la_restaurant/modules/workers/workers.dart';
import 'package:al3la_restaurant/shared/change_language.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneStateNavigatorDrawer();
  }
}

class OneStateNavigatorDrawer extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return RestaurantInformation(
                        restaurantInformationModel: restaurantInformationModel,
                      );
                    }),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.circleInfo,
                        color: defaultColor,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        child: Text(
                          getTranslated(context,
                              'Admin_Navigation_button_Restaurant_information'),
                          style: const TextStyle(
                              color: defaultColor, fontSize: 20),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  navigateTo(context, const WorkersScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.user,
                        color: defaultColor,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Text(
                        getTranslated(
                            context, 'Admin_Navigation_button_Add_worker'),
                        style:
                            const TextStyle(color: defaultColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  showLanguageDialog(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.language,
                        color: defaultColor,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Text(
                        getTranslated(context,
                            'Setting_Page_Title_ChangeLanguage_button'),
                        style: const TextStyle(
                            color: defaultColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  navigateTo(context, const OrdersScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.cartArrowDown,
                        color: defaultColor,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Text(
                        getTranslated(
                            context, 'User_Navigation_button_Cart_Restaurant'),
                        style:
                            const TextStyle(color: defaultColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  navigateTo(context, const QrScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.qrcode,
                        color: defaultColor,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Text(
                        getTranslated(
                            context, 'Admin_Navigation_button_QR_Screen'),
                        style:
                            const TextStyle(color: defaultColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
