import 'package:al3la_restaurant/modules/cart_screen/cart_user_screen.dart';
import 'package:al3la_restaurant/shared/change_language.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneStateNavigatorDrawer();
  }
}

class OneStateNavigatorDrawer extends State<UserDrawer> {
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
                  navigateTo(context, CartScreen());
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
                        getTranslated(context,
                            'User_Navigation_button_Cart_Restaurant'),
                        style: const TextStyle(
                            color: defaultColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
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
              const Spacer(),
              if (restaurantInformationModel?.numberPhone != null)
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: "${restaurantInformationModel?.numberPhone}",
                        );
                        await launch(launchUri.toString());
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.phone,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTranslated(context,
                                    'User_Navigation_button_Call_Restaurant'),
                                style: const TextStyle(color: defaultColor),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: defaultColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer {
  String title;
  Function pathPage;

  NavigationDrawer(this.title, this.pathPage);
}
