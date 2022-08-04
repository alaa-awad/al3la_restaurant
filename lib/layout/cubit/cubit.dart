import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/main.dart';
import 'package:al3la_restaurant/models/Workers.dart';
import 'package:al3la_restaurant/models/cart.dart';
import 'package:al3la_restaurant/models/category.dart';
import 'package:al3la_restaurant/models/meal.dart';
import 'package:al3la_restaurant/models/restaurant_information.dart';
import 'package:al3la_restaurant/models/user_module.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitHomeCubit());

  static HomeCubit get(context) => BlocProvider.of(context);

  // all function User

  void getUser({required String idUser}) {
    emit(GetUserLoadingStates());
    FirebaseFirestore.instance
        .collection("User")
        .doc(idUser)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessStates());
    }).catchError((error) {
      print('get user error state is ${error.toString()}');
      emit(GetUserErrorStates(error.toString()));
    });
  }

  //function to get category from firebase
  List<CategoryModel> category = [];
  void getCategory({required String idUser}) {
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Foods')
        .doc('ar')
        .collection('Category')
        .get()
        .then((value) {
      emit(GetCategoryLoadingStates());
      category = [];
      for (var element in value.docs) {
        category.add(CategoryModel.fromJson(element.data()));
      }
      emit(GetCategorySuccessStates());
    }).catchError((error) {
      print('Error get Category is ${error.toString()}');
      emit(GetCategoryErrorStates(error));
    });
  }

  // all function to get meal from firebase
  List<MealModule> meals = [];
  void getMeal({required String idUser, required String category}) {
    meals = [];
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Foods')
        .doc('ar')
        .collection('Category')
        .doc(category)
        .collection('Meals')
        .get()
        .then((value) {
      emit(GetMealLoadingStates());
      for (var element in value.docs) {
        meals.add(MealModule.fromJson(element.data()));
      }
      emit(GetMealSuccessStates());
    }).catchError((error) {
      print('Error get Meal is ${error.toString()}');
      emit(GetMealErrorStates(error));
    });
  }

  // all function to get meal from firebase

  void getRestaurantInformation({required String idUser}) {
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .get()
        .then((value) {
      emit(GetRestaurantInformationLoadingStates());
      restaurantInformationModel =
          RestaurantInformationModel.fromJson(value.data());
      emit(GetRestaurantInformationSuccessStates());
    }).catchError((error) {
      print('Error get Restaurant Information is ${error.toString()}');
      emit(GetRestaurantInformationErrorStates(error));
    });
  }

  void addRestaurantInformation({
    required String idUser,
    required String name,
    String? location,
    num? numberPhone,
    String? facebookAccount,
    String? instagramAccount,
    required BuildContext context,
  }) {
    emit(AddRestaurantInformationLoadingStates());
    RestaurantInformationModel restaurantInformationModel =
        RestaurantInformationModel(
      name: name,
      location: location,
      numberPhone: numberPhone,
      facebookAccount: facebookAccount,
      instagramAccount: instagramAccount,
    );
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .set(restaurantInformationModel.toJson())
        .then((value) {
      emit(AddRestaurantInformationSuccessStates());
    }).catchError(((error) {
      print('Error add Restaurant Information is ${error.toString()}');
      emit(AddRestaurantInformationErrorStates(error.toString()));
    }));
  }

  // function change language
  void changeLanguage(String value, BuildContext context) {
    CacheHelper.sharedPreferences.setString('language', value);
    navigateAndFinish(context, MyApp());
  }

  // all function workers

  void getWorker({required String idUser, required String id}) {
    emit(GetWorkerLoadingStates());
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .doc(id)
        .get()
        .then((value) {
      workerModel = WorkerModel.fromJson(value.data());
      emit(GetWorkerSuccessStates());
    }).catchError((error) {
      print('get worker error state is ${error.toString()}');
      emit(GetWorkerErrorStates(error.toString()));
    });
  }

  List<WorkerModel> workers = [];
  List<String> idWorkers = [];
  void getWorkers({required String idUser}) {
    workers = [];
    idWorkers = [];
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .get()
        .then((value) {
      emit(GetWorkersLoadingStates());
      for (var element in value.docs) {
        workers.add(WorkerModel.fromJson(element.data()));
        idWorkers.add(WorkerModel.fromJson(element.data()).id);
      }
      emit(GetWorkersSuccessStates());
    }).catchError((error) {
      print('Error get workers is ${error.toString()}');
      emit(GetWorkersErrorStates(error));
    });
  }

  void addWorker({
    required String id,
    required String name,
    required String password,
    required String idUser,
    required String type,
    required BuildContext context,
  }) {
    emit(AddWorkerLoadingStates());
    WorkerModel workerModule =
        WorkerModel(id: id, name: name, password: password, type: type);
    /*  FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .add(workerModworkerModule))
        .then((value) {
      workerModule = WorkerModel(id: value.id, name: name, password: password);*/
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .doc(id)
        .set(workerModule.toJson())
        .then((value) {
      emit(AddWorkerSuccessStates());
    }).catchError(((error) {
      print('Error add worker is ${error.toString()}');
      emit(AddWorkerErrorStates(error));
    }));
  }

  void updateWorker({
    required String id,
    required String name,
    required String idUser,
    required String password,
    required String type,
    required BuildContext context,
  }) {
    emit(UpdateWorkerLoadingStates());
    WorkerModel workerModule =
        WorkerModel(id: id, name: name, password: password, type: type);
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .doc(id)
        .set(workerModule.toJson())
        .then((value) {
      emit(UpdateWorkerSuccessStates());
      getWorkers(idUser: idUser);
      getWorker(idUser: token!, id: id);
    }).catchError(((error) {
      print('Error update worker is ${error.toString()}');
      emit(UpdateWorkerErrorStates(error));
    }));
  }

  // function delete tablet
  void deleteWorker({
    required String idUser,
    required String name,
    required BuildContext context,
  }) {
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(idUser)
        .collection('Workers')
        .doc(name)
        .delete()
        .then((value) {
      ///ToDo: what do here
      getWorkers(idUser: idUser);
    });
  }

  /*void logOutTablet(BuildContext context) {
    CacheHelper.removeData(key: 'idTablet');
    tabletModel = null;
    navigateAndFinish(context, MyApp());
  }
*/
  List<OrderModule> orders = [];
  void addOrder({
    required MealModule mealModule,
    required int count,
  }) {
    bool foundInList = false;
    for (var item in orders) {
      if (mealModule.name == item.meal.name) {
        item.count = item.count + count;
        foundInList = true;
        break;
      }
    }
    if (foundInList == false) {
      print('add to cart');
      orders.add(OrderModule(meal: mealModule, count: count));
    }
  }

  void addCart({required int totalPrice, required String nameTable}) {
    emit(AddCartLoadingStates());
    var cart = {for (var e in orders) e.meal.name: e.count};
    print(cart);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    CartModule cartModule = CartModule(
        orders: cart,
        nameUser: token!,
        nameTablet: workerModel!.name,
        totalPrice: totalPrice,
        dateTime: formattedDate,
        nameTable: nameTable);
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(token!)
        .collection('Orders')
        .add(cartModule.toJson())
        .then((value) {
      emit(AddCartSuccessStates());
      print('order is done');
    }).catchError((error) {
      emit(AddCartErrorStates(error.toString()));
    });
  }

  List<CartModule> allOrders = [];
  void getOrders() {
    allOrders = [];
    FirebaseFirestore.instance
        .collection("Restaurant")
        .doc(token!)
        .collection('Orders')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      emit(GetOrdersLoadingStates());
      for (var element in value.docs) {
        allOrders.add(CartModule.fromJson(element.data()));
      }
      emit(GetOrdersSuccessStates());
    }).catchError((error) {
      print("Get order error is ${error.toString()}");
      emit(GetOrdersErrorStates(error.toString()));
    });
  }
}
