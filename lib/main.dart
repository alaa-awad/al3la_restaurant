import 'dart:io';
import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/modules/add/cubit/cubit.dart';
import 'package:al3la_restaurant/shared/bloc_observer.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/localization/app_local.dart';
import 'package:al3la_restaurant/shared/network/local/cache_helper.dart';
import 'package:al3la_restaurant/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:al3la_restaurant/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  decisionHomeScreen();
  //isAdmin = CacheHelper.getData(key: "isAdmin");
  language = CacheHelper.getData(key: 'language');
  print("Language is ${Platform.localeName}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final idTablet = CacheHelper.getData(key: 'idTablet');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AddCubit()),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getUser(idUser: '$token')
              ..getCategory(idUser: '$token')),
      ],
      child: MaterialApp(
        title: 'Al3la Restaurant',

        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        //   locale: const Locale('ar', ''),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocale.delegate,
        ],
        localeResolutionCallback: (currentLocale, supportedLocale) {
          if (currentLocale != null) {
            for (Locale locale in supportedLocale) {
              if (currentLocale.languageCode == locale.languageCode) {
                return currentLocale;
              }
            }
          }
          return supportedLocale.first;
          //
        },
        locale: language != null ? Locale('$language', '') : null,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: Builder(builder: (context) {
          if (token != null) {
            HomeCubit.get(context).getRestaurantInformation(idUser: "$token");
          }
          /*     if (idTablet != null) {
            HomeCubit.get(context)
                .getTablet(idUser: "$token", idTablet: idTablet!);
          }*/
          return home;
        }),
      ),
    );
  }
}
