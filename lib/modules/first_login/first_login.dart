import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/modules/restaurant_information/restaurant_information.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/adaptive/adaptive_button.dart';

class FirstLogin extends StatelessWidget {

  String idRestaurant ;
  var formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirstLogin(this.idRestaurant,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    idController.text = "1";
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (state, index) {},
      builder: (state, index) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(getTranslated(
                        context, "First_Login_page_Title_page_text"),
                    style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      isClickable: false,
                      label: getTranslated(context,
                          'First_Login_page_body_text_filed_add_id_label'),
                      controller: idController,
                      type: TextInputType.number,
                      prefix: FontAwesomeIcons.idBadge,
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      label: getTranslated(context,
                          'First_Login_page_body_text_filed_add_name_label'),
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'First_Login_page_body_text_filed_add_name_validate_isEmpty');
                        }
                      },
                      prefix: FontAwesomeIcons.tablet,
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      label: getTranslated(context,
                          'First_Login_page_body_text_filed_add_password_label'),
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'First_Login_page_body_text_filed_add_password_validate_isEmpty');
                        }
                      },
                      prefix: FontAwesomeIcons.lock,
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
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text.length < 6) {
                            showToast(
                                text: getTranslated(context,
                                    "First_Login_page_body_text_filed_password_isWeak"),
                                state: ToastStates.error);
                          } else {
                            HomeCubit.get(context).addWorker(
                                id: idController.text,
                                name: nameController.text,
                                idUser: token!,
                                context: context,
                                password: passwordController.text,
                                type: "owner");
                            navigateAndFinish(context, RestaurantInformation());
                          }
                        }
                      },
                      text: getTranslated(
                          context, 'First_Login_page_body_button_Add_worker')),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
