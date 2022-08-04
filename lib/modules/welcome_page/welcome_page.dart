import 'package:al3la_restaurant/modules/Authentication/login_screen.dart';
import 'package:al3la_restaurant/modules/qr_screen/qr_scanner.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              getTranslated(context, "Welcome_page_Title_text"),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 30,
            ),
            AdaptiveButton(
              os: getOs(),
              background: defaultColor,
              function: () {
                navigateTo(context, const QrScanner());
              },
              text: getTranslated(context, "Welcome_page_button_qr_text"),
              isUpperCase: true,
              radius: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            AdaptiveButton(
              os: getOs(),
              background: defaultColor,
              function: () {
                navigateTo(context, LoginScreen());
              },
              text: getTranslated(context, 'Welcome_page_button_LogIn_text'),
              isUpperCase: true,
              radius: 20,
            )
          ],
        ),
      ),
    );
  }
}
