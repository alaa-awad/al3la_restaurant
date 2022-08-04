import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/category.dart';
import 'package:al3la_restaurant/models/meal.dart';
import 'package:al3la_restaurant/modules/drawer/user_drawer.dart';
import 'package:al3la_restaurant/modules/food_screen/food_details_page.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

String nameCategory = '';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return userModel == null
            ? Scaffold(
                ///ToDo: Change it to logo app or name restaurant
                body: Center(
                    child: AdaptiveIndicator(
                  os: getOs(),
                )),
              )
            : Scaffold(
                key: globalKey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  elevation: 0,
                  title: Column(
                    children: [
                      Text(
                        '${restaurantInformationModel?.name}',
                        style: const TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/menu.svg',
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //Scaffold.of(context).openDrawer();
                      globalKey.currentState?.openDrawer();
                    },
                  ),
                ),

                /*   drawer: userModel?.type == 'Admin' && tabletModel == null
                    ? const AdminDrawer()
                    : const UserDrawer(),*/
                drawer: workerModel != null ? const UserDrawer():null,
                body: (HomeCubit.get(context).category.isEmpty)
                    ? Center(
                        child: AdaptiveIndicator(
                        os: getOs(),
                      ))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      HomeCubit.get(context).category.length,
                                  itemBuilder: (context, index) => categoryItem(
                                      context,
                                      HomeCubit.get(context).category[index])),
                            ),
                            HomeCubit.get(context).meals.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Builder(builder: (context) {
                                      HomeCubit.get(context).getMeal(
                                        category: HomeCubit.get(context)
                                            .category[0]
                                            .uId,
                                        idUser: '$token',
                                      );
                                      return loadingPage(context);
                                    }),
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        nameCategory,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            itemFoodClass(
                                                context,
                                                HomeCubit.get(context)
                                                    .meals[index]),
                                        itemCount:
                                            HomeCubit.get(context).meals.length,
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
              );
      },
    );
  }
}

Widget categoryItem(BuildContext context, CategoryModel categoryModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: InkWell(
      onTap: () {
        nameCategory = categoryModel.name;
        HomeCubit.get(context)
            .getMeal(category: categoryModel.uId, idUser: '$token');
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(categoryModel.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              categoryModel.name,
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
  );
}

Widget itemFoodClass(BuildContext context, MealModule mealModule) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          FoodDetailsPage(
            mealModule: mealModule,
          ));
    },
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(mealModule.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealModule.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                if (mealModule.describe != ' ')
                  Text(
                    mealModule.describe,
                    style: const TextStyle(
                      fontSize: 15,
                      color: kTextColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '${mealModule.price}\$',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
