import 'dart:io';
import 'package:al3la_restaurant/modules/welcome_page/welcome_page.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/font_icon/icon_broken.dart';
import 'package:al3la_restaurant/shared/network/local/cache_helper.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  // late BuildContext context;
  _OnBoardingScreenState();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          const WelcomePage(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        image:
            'https://img.freepik.com/free-vector/tiny-female-chef-cooking-vegan-meal-using-recipe-kitchen-cook-making-dish-from-restaurant-menu-flat-vector-illustration-healthy-food-diet-culinary-nutrition-concept-website-design_74855-22063.jpg?w=900',
        title: getTranslated(context, 'onboard_1_title'),
        body: getTranslated(context, 'onboard_1_body'),
      ),
      BoardingModel(
        image:
            'https://img.freepik.com/free-vector/breakfast-lunch-top-view-delicious-healthy-food-porcelain-dish-classic-hearty-breakfast-nicely-served-food-white-plate_93083-1600.jpg?w=740',
        title: getTranslated(context, 'onboard_2_title'),
        body: getTranslated(context, 'onboard_2_body'),
      ),
      BoardingModel(
        image:
            'https://img.freepik.com/free-vector/delivery-man-waiting-food_56104-672.jpg?t=st=1650947499~exp=1650948099~hmac=2e23ee4d9b624070fb69695b0c3c868ec9fda460635948981e3e3fb033b8cbd5&w=740',
        title: getTranslated(context, 'onboard_3_title'),
        body: getTranslated(context, 'onboard_3_body'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem2(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: defaultColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      }
                      else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    icon:Platform.localeName == "en_US"? const Icon(IconBroken.Arrow___Right_2,color: Colors.white):const Icon(IconBroken.Arrow___Left_2,color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem2(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(model.image),
              radius: 150,
            ),
          ),
          const SizedBox(
            height: 70.0,
          ),
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
       Text(
         model.title,
         style: const TextStyle(
           fontSize: 30.0,
           fontWeight: FontWeight.bold,
         ),
       ),
       const SizedBox(
         height: 10.0,
       ),
       Text(
         model.body,
         style: const TextStyle(
           fontSize: 15.0,
           color: Colors.grey
         ),
       ),
     ],)
        ],
      );

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}


// link menu delivery
//https://img.freepik.com/free-vector/food-delivery-service-abstract-concept-illustration-online-food-order-24-7-service-pizza-sushi-online-menu-payment-options-no-contact-delivery-download-app_335657-3507.jpg?w=740