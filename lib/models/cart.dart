import 'package:al3la_restaurant/models/meal.dart';

class OrderModule {
  late MealModule meal;
  late int count;

  OrderModule({
    required this.meal,
    required this.count,
  });

  OrderModule.fromJson(dynamic json){
    meal = json['meal'];
    count = json['count'];
  }
  Map<String,dynamic> toJson(){
    return {
      'meal' : meal,
      'count' : count,
    };
  }
}

class CartModule {
 late String dateTime;
late Map<String,dynamic> orders;
  late String nameUser;
  late String nameTablet;
  late String nameTable;
  bool state = false;
  late int totalPrice;

  CartModule({
    required this.orders,
    required this.dateTime,
    required this.nameUser,
    required this.nameTablet,
    required this.nameTable,
    required this.totalPrice,
  });

  CartModule.fromJson(dynamic json){
    orders = json['orders'];
    dateTime = json['dateTime'];
    nameUser = json['nameUser'];
    nameTablet = json['nameTablet'];
    nameTable = json['nameTable'];
    state = json['state'];
    totalPrice = json['totalPrice'];
  }
  Map<String,dynamic> toJson(){
    return {
      'orders' : orders,
      'dateTime' : dateTime,
      'nameUser' : nameUser,
      'nameTablet' : nameTablet,
      'nameTable' : nameTable,
      'state' : state,
      'totalPrice' : totalPrice,
    };
  }
}
