import 'dart:io';
import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/models/category.dart';
import 'package:al3la_restaurant/models/meal.dart';
import 'package:al3la_restaurant/modules/add/add_categories_meals.dart';
import 'package:al3la_restaurant/modules/add/cubit/state.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class AddCubit extends Cubit<AddStates> {
  AddCubit() : super(InitAddStates());

  static AddCubit get(context) => BlocProvider.of(context);

  // All variable and function to  category
  var picker = ImagePicker();

  // function add image for category
  File? categoryImage;
  Future<void> getCategoryImage({source = ImageSource.gallery}) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      categoryImage = File(pickedFile.path);
      emit(CategoryImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CategoryImagePickedErrorState());
    }
  }

  void addCategory({
    required String name,
    required String idUser,
    required BuildContext context,
  }) {
    emit(AddCategoryLoadingStates());
    //late String _idCategory;
    String? _image;
    if (categoryImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'CategoryImages/${Uri.file(categoryImage?.path as String).pathSegments.last}')
          .putFile(categoryImage as File)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          _image = value;
          CategoryModel categoryModel =
              CategoryModel(name: name, image: value, uId: '');
          FirebaseFirestore.instance
              .collection("Restaurant")
              .doc(idUser)
              .collection('Foods')
              .doc("ar")
              .collection('Category')
              .add(categoryModel.toJson())
              .then((value) {
            CategoryModel categoryModel =
                CategoryModel(name: name, image: "$_image", uId: value.id);
            FirebaseFirestore.instance
                .collection("Restaurant")
                .doc(idUser)
                .collection('Foods')
                .doc('ar')
                .collection('Category')
                .doc(value.id)
                .set(categoryModel.toJson())
                .then((value) {
              emit(AddCategorySuccessStates());
              navigateAndFinish(
                  context,
                  AddCategoriesOrMeals(
                    categoryModel: categoryModel,
                  ));
            });
          }).catchError(((error) {
            print('Error add Category is ${error.toString()}');
            emit(AddCategoryErrorStates(error));
          }));
          print(value);
        }).catchError((error) {
          emit(AddCategoryErrorStates(error.toString()));
          print('error getDownloadURL ${error.toString()}');
        });
      }).catchError((error) {
        emit(AddCategoryErrorStates(error.toString()));
        print('error putFile ${error.toString()}');
      });
    } else {
      CategoryModel categoryModel = CategoryModel(
          name: name,
          image:
              "https://image.freepik.com/free-vector/vector-cartoon-illustration-traditional-set-fast-food-meal_1441-331.jpg",
          uId: '');
      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(idUser)
          .collection('Foods')
          .doc('ar')
          .collection('Category')
          .add(categoryModel.toJson())
          .then((value) {
        CategoryModel categoryModel = CategoryModel(
            name: name,
            image:
                "https://image.freepik.com/free-vector/vector-cartoon-illustration-traditional-set-fast-food-meal_1441-331.jpg",
            uId: value.id);
        FirebaseFirestore.instance
            .collection("Restaurant")
            .doc(idUser)
            .collection('Foods')
            .doc('ar')
            .collection('Category')
            .doc(value.id)
            .set(categoryModel.toJson())
            .then((value) {
          emit(AddCategorySuccessStates());
          navigateAndFinish(
              context,
              AddCategoriesOrMeals(
                categoryModel: categoryModel,
              ));
        });
      }).catchError(((error) {
        print('Error add Category is ${error.toString()}');
        emit(AddCategoryErrorStates(error));
      }));
    }
  }

  void updateCategory({
    required String name,
    required String idUser,
    required String idCategory,
    required BuildContext context,
  }) {
    emit(UpdateCategoryLoadingStates());
    if (categoryImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'CategoryImages/${Uri.file(categoryImage?.path as String).pathSegments.last}')
          .putFile(categoryImage as File)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          CategoryModel categoryModel =
              CategoryModel(name: name, image: value, uId: idCategory);
          FirebaseFirestore.instance
              .collection("Restaurant")
              .doc(idUser)
              .collection('Foods')
              .doc('ar')
              .collection('Category')
              .doc(idCategory)
              .set(categoryModel.toJson())
              .then((value) {
            emit(UpdateCategorySuccessStates());
            navigateAndFinish(
                context,
                AddCategoriesOrMeals(
                  categoryModel: categoryModel,
                ));
          }).catchError(((error) {
            print('Error add Category is ${error.toString()}');
            emit(UpdateCategoryErrorStates(error));
          }));
          print(value);
        }).catchError((error) {
          emit(UpdateCategoryErrorStates(error.toString()));
          print('error getDownloadURL ${error.toString()}');
        });
      }).catchError((error) {
        emit(UpdateCategoryErrorStates(error.toString()));
        print('error putFile ${error.toString()}');
      });
    } else {
      CategoryModel categoryModel = CategoryModel(
          name: name,
          image:
              "https://image.freepik.com/free-vector/vector-cartoon-illustration-traditional-set-fast-food-meal_1441-331.jpg",
          uId: idCategory);
      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(idUser)
          .collection('Foods')
          .doc('ar')
          .collection('Category')
          .doc(idCategory)
          .set(categoryModel.toJson())
          .then((value) {
        emit(UpdateCategorySuccessStates());
        navigateAndFinish(
            context,
            AddCategoriesOrMeals(
              categoryModel: categoryModel,
            ));
      }).catchError(((error) {
        print('Error add Category is ${error.toString()}');
        emit(UpdateCategoryErrorStates(error));
      }));
    }
  }

  // function delete meal
  void deleteCategory({
    required String idUser,
    required String idCategory,
    required BuildContext context,
  }) {
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Foods')
        .doc('ar')
        .collection('Category')
        .doc(idCategory)
        .delete()
        .then((value) {
      HomeCubit.get(context).getCategory(idUser: idUser);
      print('delete category done');
    });
  }

  // function add image for meal
  File? mealImage;
  Future<void> getMealImage({source = ImageSource.gallery}) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      mealImage = File(pickedFile.path);
      emit(MealImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(MealImagePickedErrorState());
    }
  }

  void addMeal({
    required String idUser,
    required String name,
    required String describe,
    required String price,
    required String category,
    String state = 'new',
  }) {
    String image;
    emit(AddMealLoadingStates());
    if (mealImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'MealImages/${Uri.file(mealImage?.path as String).pathSegments.last}')
          .putFile(mealImage as File)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          image = value;
          MealModule mealModule = MealModule(
              image: value,
              price: price,
              describe: describe,
              name: name,
              state: state,
              uId: '');
          FirebaseFirestore.instance
              .collection("Restaurant")
              .doc(idUser)
              .collection('Foods')
              .doc('ar')
              .collection('Category')
              .doc(category)
              .collection('Meals')
              .add(mealModule.toJson())
              .then((value) {
            MealModule mealModule = MealModule(
                image: image,
                price: price,
                describe: describe,
                name: name,
                state: state,
                uId: value.id);
            FirebaseFirestore.instance
                .collection("Restaurant")
                .doc(idUser)
                .collection('Foods')
                .doc('ar')
                .collection('Category')
                .doc(category)
                .collection('Meals')
                .doc(value.id)
                .set(mealModule.toJson())
                .then((value) {
              emit(AddMealSuccessStates());
            });
          }).catchError(((error) {
            print('Error add meal is ${error.toString()}');
            emit(AddMealErrorStates(error));
          }));
          print(value);
        }).catchError((error) {
          emit(AddMealErrorStates(error.toString()));
          print('error getDownloadURL ${error.toString()}');
        });
      }).catchError((error) {
        emit(AddMealErrorStates(error.toString()));
        print('error putFile ${error.toString()}');
      });
    } else {
      MealModule mealModule = MealModule(
          image:
              "https://image.freepik.com/free-vector/vector-cartoon-illustration-traditional-set-fast-food-meal_1441-331.jpg",
          price: price,
          describe: describe,
          name: name,
          state: state,
          uId: '');

      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(idUser)
          .collection('Foods')
          .doc('ar')
          .collection('Category')
          .doc(category)
          .collection('Meals')
          .add(mealModule.toJson())
          .then((value) {
        MealModule mealModule = MealModule(
            image:
                "https://image.freepik.com/free-vector/vector-cartoon-illustration-traditional-set-fast-food-meal_1441-331.jpg",
            price: price,
            describe: describe,
            name: name,
            state: state,
            uId: value.id);
        FirebaseFirestore.instance
            .collection("Restaurant")
            .doc(idUser)
            .collection('Foods')
            .doc('ar')
            .collection('Category')
            .doc(category)
            .collection('Meals')
            .doc(value.id)
            .set(mealModule.toJson())
            .then((value) {
          emit(AddMealSuccessStates());
        });
      }).catchError(((error) {
        print('Error add meal is ${error.toString()}');
        emit(AddMealErrorStates(error));
      }));
    }
  }

  void updateMeal({
    required String idUser,
    required String uId,
    required String name,
    required String describe,
    required String price,
    required String categoryUid,
    required String image,
    String state = 'new',
  }) {
    //String image;
    emit(UpdateMealLoadingStates());
    if (mealImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'MealImages/${Uri.file(mealImage?.path as String).pathSegments.last}')
          .putFile(mealImage as File)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          MealModule mealModule = MealModule(
              image: value,
              price: price,
              describe: describe,
              name: name,
              state: state,
              uId: uId);
          FirebaseFirestore.instance
              .collection("Restaurant")
              .doc(idUser)
              .collection('Foods')
              .doc('ar')
              .collection('Category')
              .doc(categoryUid)
              .collection('Meals')
              .doc(uId)
              .set(mealModule.toJson())
              .then((value) {
            emit(UpdateMealSuccessStates());
          }).catchError(((error) {
            print('Error update meal is ${error.toString()}');
            emit(UpdateMealErrorStates(error));
          }));
        }).catchError((error) {
          emit(UpdateMealErrorStates(error.toString()));
          print('error getDownloadURL ${error.toString()}');
        });
      }).catchError((error) {
        emit(UpdateMealErrorStates(error.toString()));
        print('error putFile ${error.toString()}');
      });
    } else {
      MealModule mealModule = MealModule(
          image:image,
          price: price,
          describe: describe,
          name: name,
          state: state,
          uId: uId);

      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(idUser)
          .collection('Foods')
          .doc('ar')
          .collection('Category')
          .doc(categoryUid)
          .collection('Meals')
          .doc(uId)
          .set(mealModule.toJson())
          .then((value) {
        emit(UpdateMealSuccessStates());
      }).catchError(((error) {
        print('Error update meal is ${error.toString()}');
        emit(UpdateMealErrorStates(error));
      }));
    }
  }

  // function delete meal
  void deleteMeal({
    required String idUser,
    required String idCategory,
    required String idMeal,
    required BuildContext context,
  }) {
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Foods')
        .doc('ar')
        .collection('Category')
        .doc(idCategory)
        .collection('Meals')
        .doc(idMeal)
        .delete()
        .then((value) {
      HomeCubit.get(context).getMeal(idUser: idUser, category: idCategory);
      print('delete meal done');
    });
  }
}
