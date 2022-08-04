import 'package:al3la_restaurant/modules/Authentication/cubit/cubit.dart';
import 'package:al3la_restaurant/modules/Authentication/cubit/states.dart';
import 'package:al3la_restaurant/modules/Authentication/login_screen.dart';
import 'package:al3la_restaurant/modules/first_login/first_login.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/network/local/cache_helper.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {
          if (state is CreateUserErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              token = state.uId;
              navigateAndFinish(context, FirstLogin(state.uId));
            });
          }
          /*   if (state is SignInFacebookSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const RestaurantPage());
            });
          }*/
        },
        builder: (context, state) {
          AuthenticationCubit authenticationCubit =
              AuthenticationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: state is CreateUserLoadingState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, 'Add_user_title'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label:
                                  getTranslated(context, 'Add_user_label_name'),
                              controller: nameController,
                              type: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_name');
                                }
                              },
                              prefix: Icons.person,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_email'),
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_email');
                                }
                              },
                              prefix: Icons.email,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_password'),
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_password');
                                }
                                if (value.length < 4) {
                                  return getTranslated(context,
                                      'add_user_password_controller_validate_isWeek');
                                }
                              },
                              prefix: Icons.lock_outline,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                              suffix: authenticationCubit.suffix,
                              suffixPressed: () {
                                authenticationCubit.changePasswordVisibility();
                              },
                              isPassword: authenticationCubit.isPassword,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_user_label_confirmPassword'),
                              controller: confirmPasswordController,
                              type: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(context,
                                      'Add_user_validate_confirmPassword');
                                }
                              },
                              prefix: Icons.lock_outline,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                              suffix: authenticationCubit.suffix,
                              suffixPressed: () {
                                authenticationCubit.changePasswordVisibility();
                              },
                              isPassword: authenticationCubit.isPassword,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            state is! SignUpLoadingState ||
                                    state is SignUpErrorState
                                ? AdaptiveButton(
                                    radius: 20,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        if (passwordController.text ==
                                            confirmPasswordController.text) {
                                          authenticationCubit
                                              .signUpWithEmailAndPassword(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text
                                                .toString(),
                                            context: context,
                                          );
                                        } else {
                                          showToast(
                                              text: getTranslated(context,
                                                  "Add_user_showToast_error"),
                                              state: ToastStates.error);
                                        }
                                        // navigateTo(context,ProductsScreen());
                                      }
                                    },
                                    text: getTranslated(
                                        context, 'Add_user_text_button'),
                                    isUpperCase: true,
                                    background: defaultColor,
                                    os: getOs(),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            setSpaceBetween(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  getTranslated(context, 'LogIn_text_or'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            setSpaceBetween(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    authenticationCubit
                                        .signInWithFacebook(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/facebook.png')),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15)),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                setSpaceBetween(width: 25),
                                InkWell(
                                  onTap: () {
                                    authenticationCubit.signInWithGoogle(
                                        context: context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/gmail.png')),
                                      borderRadius:
                                          const BorderRadius.all( Radius.circular(15)),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            setSpaceBetween(height: 23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated(
                                      context, 'Add_user_text_register'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    getTranslated(context,
                                        'Add_user_text_button_register'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.blue,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

//enum addUserType { user, supervisor, admin }
