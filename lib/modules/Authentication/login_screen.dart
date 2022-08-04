import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/modules/Authentication/cubit/cubit.dart';
import 'package:al3la_restaurant/modules/Authentication/cubit/states.dart';
import 'package:al3la_restaurant/modules/Authentication/register_screen.dart';
import 'package:al3la_restaurant/modules/check_user/logIn_worker.dart';
import 'package:al3la_restaurant/modules/restaurant_page/restaurant_page.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/network/local/cache_helper.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              token = state.uId;
              HomeCubit.get(context)
                  .getRestaurantInformation(idUser: state.uId);
              navigateAndFinish(context, LogInWorkersScreen());
            });
          }
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const RestaurantPage());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is LoginSuccessState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              setSpaceBetween(height: 50),
                              const SizedBox(
                                height: 200,
                                child: Image(
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg?t=st=1645145165~exp=1645145765~hmac=dd14710b06ae123c5b44548e67ac2010039152565d0f5fbad0b036c23726ddf0&w=740'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                getTranslated(context, 'LogIn_title'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              setSpaceBetween(height: 30),
                              Container(
                                color: Colors.white,
                                child: AdaptiveTextField(
                                  os: getOs(),
                                  label: getTranslated(
                                      context, 'LogIn_email_textFiled_hint'),
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context,
                                          'LogIn_email_controller_validate_isEmpty');
                                    }
                                  },
                                  prefix: Icons.email,
                                  textInputAction: TextInputAction.next,
                                  inputBorder: const UnderlineInputBorder(),
                                ),
                              ),
                              setSpaceBetween(height: 15),
                              Container(
                                color: Colors.white,
                                child: AdaptiveTextField(
                                  os: getOs(),
                                  label: getTranslated(
                                      context, 'LogIn_password_textFiled_hint'),
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {
                                      AuthenticationCubit.get(context)
                                          .userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  isPassword: AuthenticationCubit.get(context)
                                      .isPassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context,
                                          'LogIn_password_controller_validate_isEmpty');
                                    }
                                  },
                                  prefix: Icons.lock_outline,
                                  textInputAction: TextInputAction.done,
                                  suffix:
                                      AuthenticationCubit.get(context).suffix,
                                  suffixPressed: () {
                                    AuthenticationCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  inputBorder: const UnderlineInputBorder(),
                                ),
                              ),
                              setSpaceBetween(height: 30),
                              (state is! LoginLoadingState)
                                  ? AdaptiveButton(
                                      os: getOs(),
                                      background: defaultColor,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          AuthenticationCubit.get(context)
                                              .userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      text: getTranslated(
                                          context, 'LogIn_button_text'),
                                      isUpperCase: true,
                                      radius: 20,
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
                                      AuthenticationCubit.get(context)
                                          .signInWithFacebook(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/facebook.png')),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
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
                                      AuthenticationCubit.get(context)
                                          .signInWithGoogle(context: context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/gmail.png')),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
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
                                        context, 'LogIn_text_register'),
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
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      getTranslated(context,
                                          'LogIn_text_button_register'),
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
                              setSpaceBetween(height: 20),
                            ],
                          ),
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
