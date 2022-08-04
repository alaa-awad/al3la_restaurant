import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        idController.text = "${workerModel?.id}";
        nameController.text = "${workerModel?.name}";
        passwordController.text = "${workerModel?.password}";
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    getTranslated(context, "UserProfile_page_title_text"),
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AdaptiveTextField(
                      os: getOs(),
                      label: getTranslated(
                          context, 'Workers_page_body_text_filed_add_id_label'),
                      controller: idController,
                      type: TextInputType.number,
                      isClickable: false,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'Workers_page_body_text_filed_add_id_validate_isEmpty');
                        }
                      },
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
                          'Workers_page_body_text_filed_add_name_label'),
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'Workers_page_body_text_filed_add_name_validate_isEmpty');
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
                          'Workers_page_body_text_filed_add_password_label'),
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,
                              'Workers_page_body_text_filed_add_password_validate_isEmpty');
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(getTranslated(
                            context, "UserProfile_page_title_type_text")),
                        const Spacer(),
                        Text("${workerModel?.type}"),
                      ],
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
                                    "Workers_page_body_text_filed_password_isWeak"),
                                state: ToastStates.error);
                          } else {
                            HomeCubit.get(context).updateWorker(
                                id: idController.text,
                                name: nameController.text,
                                idUser: token!,
                                context: context,
                                password: passwordController.text,
                                type: "${workerModel?.type}");
                          }
                        }
                      },
                      text: getTranslated(
                          context, 'UserProfile_page_button_text')),
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
