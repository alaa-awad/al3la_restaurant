//Language dialog contain and enum
import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

languageType? languageTypeItem = languageType.defaults;
enum languageType { defaults, ar, en }

//Language dialog
dynamic showLanguageDialog(BuildContext context) {

  choseValueLanguage();
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    dialogType: DialogType.NO_HEADER,
    width: 300,
    animType: AnimType.SCALE,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    body: const DialogContainLanguage(),
  ).show();
}

void choseValueLanguage() {

  if(language == 'ar'){
    languageTypeItem = languageType.ar;
  }
  if(language == 'en'){
    languageTypeItem = languageType.en;
  }
  if(language == 'Default'){
    languageTypeItem = languageType.defaults;
  }
}

class DialogContainLanguage extends StatelessWidget {
  const DialogContainLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                getTranslated(context, 'Setting_Page_Title_Dialog_ChangeLanguage'),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              setSpaceBetween(height: 10),
              SizedBox(
                width: 80,
                child: myDivider(),
              ),
              RadioListTile<languageType>(
                title: Text(
                  getTranslated(
                      context, 'Setting_Page_Title_Dialog_default'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: languageType.defaults,
                groupValue: languageTypeItem,
                onChanged: (languageType? value) {
                  languageTypeItem = value;
                  language = 'Default';
                  print('value is $value');
                  print(value);
                  HomeCubit.get(context).emit(ChangeLanguageState());
                },
                activeColor: Theme.of(context).iconTheme.color,
              ),
              RadioListTile<languageType>(
                title: Text(
                  'العربية',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: languageType.ar,
                groupValue: languageTypeItem,
                onChanged: (languageType? value) {
                  languageTypeItem = value;
                  language = 'ar';
                  print('language is $language');
                  HomeCubit.get(context).emit(ChangeLanguageState());
                },
                activeColor: Theme.of(context).iconTheme.color,
              ),
              RadioListTile<languageType>(
                title: Text(
                  'English',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: languageType.en,
                groupValue: languageTypeItem,
                onChanged: (languageType? value) {
                  languageTypeItem = value;
                  language = 'en';
                  print(value);
                  HomeCubit.get(context).emit(ChangeLanguageState());
                },
                activeColor: Theme.of(context).iconTheme.color,
              ),
              myDivider(),
              TextButton(
                onPressed: () {
                  HomeCubit.get(context).changeLanguage(language!, context);
                  HomeCubit.get(context).emit(ChangeLanguageState());
                },
                child: Text(
                  getTranslated(
                      context, 'Setting_Page_TitleButton_Dialog'),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
