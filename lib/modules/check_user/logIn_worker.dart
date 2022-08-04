import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/modules/check_user/check_password_screen.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInWorkersScreen extends StatelessWidget {
  LogInWorkersScreen({Key? key}) : super(key: key);

  bool isLoadingPage = false;
  @override
  Widget build(BuildContext context) {
    var screenFormKey = GlobalKey<FormState>();
    TextEditingController idController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetWorkerLoadingStates) {
          isLoadingPage = true;
        }
        if (state is GetWorkerSuccessStates) {
          isLoadingPage = false;
          navigateTo(context, CheckPasswordScreen());
        }
        if (state is GetWorkerErrorStates) {
          isLoadingPage = false;
          showToast(
              text: getTranslated(
                  context, "LogInWorker_Screen_id_worker_title_Error"),
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: isLoadingPage == false
              ? Form(
                  key: screenFormKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${restaurantInformationModel?.name}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: defaultColor),
                      ),
                    ),
                    const SizedBox(height: 20,),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(getTranslated(
                                context, "LogInWorker_Screen_id_worker_title")),
                          ),
                          AdaptiveTextField(
                            os: getOs(),
                            controller: idController,
                            hintText: getTranslated(context,
                                "LogInWorker_Screen_id_worker_title_hint"),
                            type: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return getTranslated(context,
                                    'LogInWorker_Screen_id_worker_title_validate');
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AdaptiveButton(
                            os: getOs(),
                            background: defaultColor,
                            function: () {
                              if (screenFormKey.currentState!.validate()) {
                                HomeCubit.get(context).getWorker(
                                    idUser: token!, id: idController.text);
                              }
                            },
                            text: getTranslated(context,
                                "LogInWorker_Screen_id_worker_button_text"),
                            isUpperCase: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: AdaptiveIndicator(
                    os: getOs(),
                  ),
                ),
        );
      },
    );
  }
}
