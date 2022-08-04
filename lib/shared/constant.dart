

import 'package:al3la_restaurant/models/Workers.dart';
import 'package:al3la_restaurant/models/restaurant_information.dart';
import 'package:al3la_restaurant/models/user_module.dart';
import 'package:flutter/material.dart';


UserModel? userModel;

WorkerModel? workerModel;

String? token;

//String? idTablet;

String? language;

late Widget home;

RestaurantInformationModel? restaurantInformationModel;

int totalPrice = 0;

bool orderDone = false;

String tableNumber ="0";

//bool isAdmin = true;

