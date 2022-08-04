import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/modules/categories_page/categorise_page.dart';
import 'package:al3la_restaurant/modules/restaurant_page/restaurant_page.dart';
import 'package:al3la_restaurant/modules/user_profile/user_profile.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckPasswordScreen extends StatelessWidget {
  CheckPasswordScreen({Key? key}) : super(key: key);

  List<String> passwordWorker = [];
  String password = "";

  @override
  Widget build(BuildContext context) {
    var screenFormKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: screenFormKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(
                              first: true, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                        ],
                      ),*/
                      /* const SizedBox(
                        height: 10,
                      ),*/
                      /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(
                              first: false, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                          _textFieldOTP(
                              first: false, last: false, context: context),
                        ],
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(getTranslated(context,
                            "CheckPassword_Screen_password_worker_title")),
                      ),
                      AdaptiveTextField(
                        os: getOs(),
                        controller: passwordController,
                        /*  hintText: getTranslated(context,
                            "CheckPassword_Screen_password_worker_title"),*/
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return getTranslated(context,
                                'CheckPassword_Screen_password_worker_title_validate');
                          }
                        },
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AdaptiveButton(
                        os: getOs(),
                        background: defaultColor,
                        /* function: () {
                          password = "";
                          for (var element in passwordWorker) {
                            password = password + element;
                            print(element);
                          }
                          //navigateTo(context,  CheckPasswordScreen());
                          print("password is $password");
                          if (workerModel?.password == password) {
                            print("okay");
                            showDialogChoseTable(context: context);
                          } else {
                            showToast(
                                text: getTranslated(context,
                                    "CheckPassword_Screen_password_worker_error"),
                                state: ToastStates.error);
                          }
                        },*/
                        function: () {
                          if (screenFormKey.currentState!.validate()) {
                            if (workerModel?.password ==
                                passwordController.text) {
                              if (workerModel?.type == "admin") {
                                navigateAndFinish(
                                    context, const CategoriesPage());
                              }
                              if (workerModel?.type == "owner") {
                                navigateAndFinish(
                                    context, const CategoriesPage());
                              }
                              if (workerModel?.type == "accountant") {
                                ///ToDo: add page for accountant
                                navigateTo(context, UserProfile());
                              }
                              if (workerModel?.type == "captain") {
                                showDialogChoseTable(context: context);
                              }
                            } else {
                              showToast(
                                  text: getTranslated(context,
                                      "CheckPassword_Screen_password_worker_error"),
                                  state: ToastStates.error);
                            }
                          }
                        },
                        text: getTranslated(context, "LogInWorker_Screen_id_worker_button_text"),
                        isUpperCase: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

/*  Widget _textFieldOTP(
      {required bool first, last, required BuildContext context}) {
    return SizedBox(
      height: 80,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          //obscureText: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              passwordWorker.add(value);
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
              passwordWorker.removeLast();
            }
            if (value.isEmpty && first == true) {
              passwordWorker.removeLast();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }*/

  dynamic showDialogChoseTable({
    required BuildContext context,
  }) {
    var formKey = GlobalKey<FormState>();
    TextEditingController tableController = TextEditingController();
    return AwesomeDialog(
        context: context,
        dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        dialogType: DialogType.QUESTION,
        width: 300,
        animType: AnimType.SCALE,
        buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
        body: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getTranslated(
                      context, "CheckPassword_Screen_choose_table_title"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AdaptiveTextField(
                    os: getOs(),
                    controller: tableController,
                    type: TextInputType.number,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                            context, 'CheckPassword_Screen_choose_table_title');
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                AdaptiveButton(
                  os: getOs(),
                  function: () {
                    if (formKey.currentState!.validate()) {
                      /*  if (orderDone == false) {
                        HomeCubit.get(context).addCart(
                            totalPrice: totalPrice,
                            nameTable: tableController.text);
                      } else {
                        //  HomeCubit.get(context).updateCart(totalPrice: totalPrice, nameTable: tableController.text);
                      }*/
                      tableNumber = tableController.text;
                      Navigator.of(context, rootNavigator: true).pop();
                      navigateAndFinish(context, const RestaurantPage());
                    }
                  },
                  text: getTranslated(
                      context, "CheckPassword_Screen_choose_table_button"),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )).show();
  }
}
