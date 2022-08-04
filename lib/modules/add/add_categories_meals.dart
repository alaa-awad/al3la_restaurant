import 'dart:io';
import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/category.dart';
import 'package:al3la_restaurant/models/meal.dart';
import 'package:al3la_restaurant/modules/add/cubit/cubit.dart';
import 'package:al3la_restaurant/modules/add/cubit/state.dart';
import 'package:al3la_restaurant/modules/categories_page/categorise_page.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isLoadingMeals = false;
bool isLoadingCategoryPage = false;

class AddCategoriesOrMeals extends StatelessWidget {
  CategoryModel? categoryModel;
  // String? imageCategory;
  AddCategoriesOrMeals({Key? key, this.categoryModel}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  var addCategoryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddStates>(
      listener: (context, state) {
        if (state is AddMealSuccessStates || state is UpdateMealSuccessStates) {
          isLoadingMeals = false;
        }
        if (state is AddCategorySuccessStates) {
          isLoadingCategoryPage = false;
        }
      },
      builder: (context, state) {
        if (categoryModel != null) {
          nameController.text = '${categoryModel?.name}';
          HomeCubit.get(context)
              .getMeal(idUser: '$token', category: '${categoryModel?.uId}');

          /* if (categoryModel?.image != null) {
        imageCategory = "${categoryModel?.image}";
      }*/
        }
        return Scaffold(
          appBar: AppBar(
            title: categoryModel == null
                ? Text(getTranslated(context, 'add_category_page_appBar_title'))
                : Text(getTranslated(context, 'add_meal_page_appBar_title')),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                AddCubit.get(context).categoryImage = null;
                navigateAndFinish(context, const CategoriesPage());
              },
            ),
          ),
          body: isLoadingCategoryPage
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: addCategoryFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            CircleAvatar(
                              backgroundImage: AddCubit.get(context)
                                          .categoryImage ==
                                      null
                                  ? categoryModel == null
                                      ? const AssetImage(
                                          'assets/images/addPhoto.jpg')
                                      : NetworkImage('${categoryModel?.image}')
                                          as ImageProvider
                                  : FileImage(AddCubit.get(context)
                                      .categoryImage as File),
                              radius: 70,
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18,
                                  )),
                              onPressed: () {
                                AddCubit.get(context).getCategoryImage();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AdaptiveTextField(
                            label: getTranslated(context,
                                'add_category_page_body_text_filed_add_name_label'),
                            controller: nameController,
                            os: getOs(),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return getTranslated(context,
                                    'add_category_page_body_text_filed_add_name_validate_isEmpty');
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        categoryModel != null
                            ? AdaptiveButton(
                                os: getOs(),
                                function: () {
                                  if (addCategoryFormKey.currentState!
                                      .validate()) {
                                    AddCubit.get(context).updateCategory(
                                        name: nameController.text,
                                        context: context,
                                        idCategory: "${categoryModel?.uId}",
                                        idUser: "$token");
                                  }
                                },
                                text: getTranslated(context,
                                    'add_category_page_body_button_update_category'))
                            : AdaptiveButton(
                                os: getOs(),
                                function: () {
                                  if (addCategoryFormKey.currentState!
                                      .validate()) {
                                    AddCubit.get(context).addCategory(
                                        name: nameController.text,
                                        context: context,
                                        idUser: "$token");
                                    isLoadingCategoryPage = true;
                                  }
                                },
                                text: getTranslated(context,
                                    'add_category_page_body_button_add_category')),
                        if (categoryModel != null)
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        getTranslated(context,
                                            "add_meal_page_appBar_title"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(fontSize: 17),
                                      )),
                                      IconButton(
                                          onPressed: () {
                                            AddCubit.get(context).mealImage =
                                                null;
                                            showItemDialog(
                                                context: context,
                                                categoryModel: categoryModel!);
                                          },
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                  isLoadingMeals
                                      ? Column(
                                          children: const [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CircularProgressIndicator(),
                                          ],
                                        )
                                      : BlocConsumer<HomeCubit, HomeState>(
                                          builder: (context, state) {
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: HomeCubit.get(context)
                                                  .meals
                                                  .length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return itemMeal(
                                                    context: context,
                                                    categoryModel:
                                                        categoryModel!,
                                                    mealModule:
                                                        HomeCubit.get(context)
                                                            .meals[index]);
                                              },
                                            );
                                          },
                                          listener: (context, state) {}),
                                ],
                              ))
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

dynamic showItemDialog(
    {required BuildContext context,
    MealModule? mealModule,
    required CategoryModel categoryModel}) {
  String? imageItem;
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController describeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    width: MediaQuery.of(context).size.width * 0.9,
    animType: AnimType.SCALE,
    dialogType: DialogType.NO_HEADER,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    body: BlocConsumer<AddCubit, AddStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (mealModule != null) {
          nameController.text = mealModule.name;
          describeController.text = mealModule.describe;
          priceController.text = mealModule.price;
          imageItem = mealModule.image;
        }
        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: AddCubit.get(context).mealImage == null
                        ? mealModule?.image == null
                            ? const AssetImage('assets/images/addPhoto.jpg')
                            : NetworkImage('${mealModule?.image}')
                                as ImageProvider
                        : FileImage(AddCubit.get(context).mealImage as File),
                    radius: 70,
                  ),
                  IconButton(
                    icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                        )),
                    onPressed: () {
                      AddCubit.get(context).getMealImage();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(
                      context, 'add_meal_page_body_text_filed_add_name_label'),
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'add_meal_page_body_text_filed_add_name_validate_isEmpty');
                    }
                  },
                  prefix: Icons.fastfood_outlined,
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(context,
                      'add_meal_page_body_text_filed_add_describe_label'),
                  controller: describeController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'add_meal_page_body_text_filed_add_describe_validate_isEmpty');
                    }
                  },
                  prefix: Icons.description,
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(
                      context, 'add_meal_page_body_text_filed_add_price_label'),
                  controller: priceController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,
                          'add_meal_page_body_text_filed_add_price_validate_isEmpty');
                    }
                  },
                  prefix: Icons.attach_money,
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
              mealModule != null
                  ? AdaptiveButton(
                      os: Platform.operatingSystem,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          AddCubit.get(context).updateMeal(
                              idUser: token!,
                              uId: mealModule.uId,
                              name: nameController.text,
                              describe: describeController.text,
                              price: priceController.text,
                              categoryUid: categoryModel.uId,
                              image: mealModule.image);
                          Navigator.of(context, rootNavigator: true).pop();
                          isLoadingMeals = true;
                        }
                      },
                      text: getTranslated(
                          context, 'add_meal_page_body_button_update_meal'))
                  : AdaptiveButton(
                      os: Platform.operatingSystem,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          AddCubit.get(context).addMeal(
                            name: nameController.text,
                            idUser: '$token',
                            category: categoryModel.uId,
                            describe: describeController.text,
                            price: priceController.text,
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                        isLoadingMeals = true;
                      },
                      text: getTranslated(
                          context, 'add_meal_page_body_button_add_meal')),
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

Widget itemMeal(
    {required BuildContext context,
    required MealModule mealModule,
    required CategoryModel categoryModel}) {
  return InkWell(
    onTap: () {
      AddCubit.get(context).mealImage = null;
      showItemDialog(
          context: context,
          categoryModel: categoryModel,
          mealModule: mealModule);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: defaultColor),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: mealModule.image == null
                    ? const AssetImage('assets/images/addPhoto.jpg')
                    : NetworkImage(mealModule.image) as ImageProvider,
                radius: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    mealModule.name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 20),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialogDelete(
                      context: context,
                      function: () {
                        AddCubit.get(context).deleteMeal(
                            idUser: token!,
                            idCategory: categoryModel.uId,
                            idMeal: mealModule.uId,
                            context: context);
                      },
                      btnOkText: getTranslated(context, "showDialog_OK_title"),
                      btnCancelText:
                          getTranslated(context, "showDialog_Cancel_title"),
                      title: mealModule.name,
                      describe: getTranslated(
                          context, 'add_meal_page_body_button_delete_meal'));
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 35,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
