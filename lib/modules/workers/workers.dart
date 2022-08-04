import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/Workers.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool isLoadingWorker = false;
String type = "";

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getWorkers(idUser: token!);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddWorkerSuccessStates) {
          isLoadingWorker = false;
          HomeCubit.get(context).getWorkers(idUser: token!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showWorkerDialog(context: context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: (HomeCubit.get(context).workers.isEmpty)
              ? Center(
                  child: AdaptiveIndicator(
                  os: getOs(),
                ))
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: HomeCubit.get(context).workers.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 7,
                    );
                  },
                  itemBuilder: (context, index) {
                    return index == 0 && workerModel?.type != "owner"
                        ? Container()
                        : workerItem(
                            context, HomeCubit.get(context).workers[index]);
                  }),
        );
      },
    );
  }
}

Widget workerItem(BuildContext context, WorkerModel workerModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      color: Colors.white,
      child: Card(
        child: SizedBox(
          height: 75,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showWorkerDialog(
                          context: context, workerModel: workerModel);
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          workerModel.id,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          workerModel.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(workerModel.type != "owner")
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialogDelete(
                            context: context,
                            function: () {
                              HomeCubit.get(context).deleteWorker(
                                  idUser: token!,
                                  context: context,
                                  name: workerModel.name);
                            },
                            btnOkText:
                                getTranslated(context, "showDialog_OK_title"),
                            btnCancelText: getTranslated(
                                context, "showDialog_Cancel_title"),
                            title: workerModel.name,
                            describe: getTranslated(
                                context, 'Tablets_page_body_showDialogDelete'));
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      iconSize: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

dynamic showWorkerDialog(
    {required BuildContext context, WorkerModel? workerModel}) {
  var formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  if (workerModel != null) {
    valueWorkerTypeItem(workerModel.type);
  } else {
    workerTypeItem = WorkerType.captain;
  }
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    width: MediaQuery.of(context).size.width * 0.9,
    animType: AnimType.SCALE,
    dialogType: DialogType.NO_HEADER,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (workerModel != null) {
          nameController.text = workerModel.name;
          idController.text = workerModel.id;
          passwordController.text = workerModel.password;
        }
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              //if (workerModel == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AdaptiveTextField(
                  os: getOs(),
                  isClickable: (workerModel == null) ? true : false,
                  label: getTranslated(
                      context, 'Workers_page_body_text_filed_add_id_label'),
                  controller: idController,
                  type: TextInputType.number,
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
              //  if (workerModel == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(
                      context, 'Workers_page_body_text_filed_add_name_label'),
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
              if (workerModel?.type != "owner")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(getTranslated(context,
                          "Workers_page_body_change_radioList_type_title")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    radioList(
                        context,
                        WorkerType.admin,
                        getTranslated(context,
                            "Workers_page_body_change_radioList_type_admin")),
                    radioList(
                        context,
                        WorkerType.captain,
                        getTranslated(context,
                            "Workers_page_body_change_radioList_type_captain")),
                    radioList(
                        context,
                        WorkerType.accountant,
                        getTranslated(context,
                            "Workers_page_body_change_radioList_type_accountant")),
                  ],
                ),
              workerModel != null
                  ? AdaptiveButton(
                      os: getOs(),
                      function: () {
                        if (workerModel.type == "owner") {
                          type = "owner";
                        } else {
                          valueType();
                        }
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
                                type: type);
                            Navigator.of(context, rootNavigator: true).pop();
                            isLoadingWorker = true;
                          }
                        }
                      },
                      text: getTranslated(
                          context, 'Workers_page_body_button_update_worker'))
                  : AdaptiveButton(
                      os: getOs(),
                      function: () {
                        valueType();
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text.length < 6) {
                            showToast(
                                text: getTranslated(context,
                                    "Workers_page_body_text_filed_password_isWeak"),
                                state: ToastStates.error);
                          } else {
                            if (HomeCubit.get(context)
                                .idWorkers
                                .contains(idController.text)) {
                              showToast(
                                  text: getTranslated(context,
                                      "Workers_page_body_id_isExisting"),
                                  state: ToastStates.error);
                            } else {
                              HomeCubit.get(context).addWorker(
                                id: idController.text,
                                name: nameController.text,
                                idUser: '$token',
                                context: context,
                                password: passwordController.text,
                                type: type,
                              );
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          }
                          isLoadingWorker = true;
                        }
                      },
                      text: getTranslated(
                          context, 'Workers_page_body_button_Add_worker')),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    ),
  ).show();
}

void valueType() {
  if (workerTypeItem == WorkerType.admin) {
    type = "admin";
  }
  if (workerTypeItem == WorkerType.captain) {
    type = "captain";
  }
  if (workerTypeItem == WorkerType.accountant) {
    type = "accountant";
  }
}

void valueWorkerTypeItem(var workerType) {
  if (workerType == "admin") {
    workerTypeItem = WorkerType.admin;
  }
  if (workerType == "captain") {
    workerTypeItem = WorkerType.captain;
  }
  if (workerType == "accountant") {
    workerTypeItem = WorkerType.accountant;
  }
}

WorkerType? workerTypeItem = WorkerType.captain;

enum WorkerType { admin, captain, accountant }

Widget radioList(BuildContext context, var workerType, String title) {
  return RadioListTile<WorkerType>(
    title: Text(
      title,
      style: Theme.of(context).textTheme.subtitle1,
    ),
    value: workerType,
    groupValue: workerTypeItem,
    onChanged: (WorkerType? value) {
      workerTypeItem = value;
      HomeCubit.get(context).emit(ChangeTypeWorkerState());
    },
    activeColor: Theme.of(context).iconTheme.color,
  );
}
