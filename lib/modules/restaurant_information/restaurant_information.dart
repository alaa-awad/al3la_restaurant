import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/restaurant_information.dart';
import 'package:al3la_restaurant/modules/categories_page/categorise_page.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/styles/colors.dart';

class RestaurantInformation extends StatelessWidget {
  RestaurantInformationModel? restaurantInformationModel;
  RestaurantInformation({this.restaurantInformationModel, Key? key})
      : super(key: key);

  var formKeyRestaurantInformation = GlobalKey<FormState>();
  TextEditingController nameRestaurantController = TextEditingController();
  TextEditingController locationRestaurantController = TextEditingController();
  TextEditingController numberPhoneRestaurantController =
      TextEditingController();
  TextEditingController facebookRestaurantController = TextEditingController();
  TextEditingController instagramRestaurantController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(
            context, 'Admin_Navigation_button_Restaurant_information')),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddRestaurantInformationSuccessStates) {
            HomeCubit.get(context).getRestaurantInformation(idUser: token!);
            navigateAndFinish(context, const CategoriesPage());
          }
        },
        builder: (context, state) {
          if (restaurantInformationModel != null) {
            nameRestaurantController.text = restaurantInformationModel!.name;
            restaurantInformationModel?.location != null
                ? locationRestaurantController.text =
                    '${restaurantInformationModel?.location}'
                : null;
            restaurantInformationModel?.numberPhone != null
                ? numberPhoneRestaurantController.text =
                    '${restaurantInformationModel?.numberPhone}'
                : null;
            restaurantInformationModel?.facebookAccount != null
                ? facebookRestaurantController.text =
                    '${restaurantInformationModel?.facebookAccount}'
                : null;
            restaurantInformationModel?.instagramAccount != null
                ? instagramRestaurantController.text =
                    '${restaurantInformationModel?.instagramAccount}'
                : null;
          }
          return SingleChildScrollView(
            child: Form(
              key: formKeyRestaurantInformation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: Text(
                      getTranslated(context,
                          'Restaurant_Information_page_TextField_label_RestaurantName'),
                      style: const TextStyle(color: defaultColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      controller: nameRestaurantController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'Restaurant_Information_page_TextField_validate_RestaurantName');
                        }
                      },
                      prefix: Icons.restaurant,
                      //textInputAction: TextInputAction.done,
                      inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: defaultColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: Text(
                      getTranslated(context,
                          'Restaurant_Information_page_TextField_label_RestaurantLocation'),
                      style: const TextStyle(color: defaultColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      controller: locationRestaurantController,
                      type: TextInputType.name,
                      /*     validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'Restaurant_Information_page_TextField_validate_RestaurantName');
                    }
                  },*/
                      prefix: FontAwesomeIcons.locationCrosshairs,
                      //textInputAction: TextInputAction.done,
                      inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: defaultColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: Text(
                      getTranslated(context,
                          'Restaurant_Information_page_TextField_label_RestaurantNumberPhone'),
                      style: const TextStyle(color: defaultColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      controller: numberPhoneRestaurantController,
                      type: TextInputType.number,
                      /*     validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'Restaurant_Information_page_TextField_validate_RestaurantName');
                    }
                  },*/
                      prefix: FontAwesomeIcons.phone,
                      //textInputAction: TextInputAction.done,
                      inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: defaultColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: Text(
                      getTranslated(context,
                          'Restaurant_Information_page_TextField_label_RestaurantFacebook'),
                      style: const TextStyle(color: defaultColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      hintText: 'facebook.com',
                      controller: facebookRestaurantController,
                      type: TextInputType.text,
                      /*     validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'Restaurant_Information_page_TextField_validate_RestaurantName');
                    }
                  },*/
                      prefix: FontAwesomeIcons.facebookF,
                      //textInputAction: TextInputAction.done,
                      inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: defaultColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: Text(
                      getTranslated(context,
                          'Restaurant_Information_page_TextField_label_RestaurantInstagram'),
                      style: const TextStyle(color: defaultColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      hintText: 'instagram.com',
                      controller: instagramRestaurantController,
                      type: TextInputType.text,
                      /*     validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'Restaurant_Information_page_TextField_validate_RestaurantName');
                    }
                  },*/
                      prefix: FontAwesomeIcons.instagram,
                      //textInputAction: TextInputAction.done,
                      inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: defaultColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AdaptiveButton(
                    os: getOs(),
                    function: () {
                      if (formKeyRestaurantInformation.currentState!
                          .validate()) {
                        HomeCubit.get(context).addRestaurantInformation(
                            idUser: '$token',
                            name: nameRestaurantController.text,
                            location: locationRestaurantController.text.isEmpty
                                ? null
                                : locationRestaurantController.text,
                            numberPhone:
                                numberPhoneRestaurantController.text.isEmpty
                                    ? null
                                    : int.parse(
                                        numberPhoneRestaurantController.text),
                            instagramAccount:
                                instagramRestaurantController.text.isEmpty
                                    ? null
                                    : instagramRestaurantController.text,
                            facebookAccount:
                                facebookRestaurantController.text.isEmpty
                                    ? null
                                    : facebookRestaurantController.text,
                            context: context);
                        HomeCubit.get(context).getRestaurantInformation(idUser: token!);
                        navigateAndFinish(context, const CategoriesPage());
                      }
                    },
                    width: 100,
                    text: getTranslated(
                        context, 'Restaurant_Information_page_Button_label'),
                    radius: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
