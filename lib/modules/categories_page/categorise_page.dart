import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/cubit/states.dart';
import 'package:al3la_restaurant/models/category.dart';
import 'package:al3la_restaurant/modules/add/add_categories_meals.dart';
import 'package:al3la_restaurant/modules/add/cubit/cubit.dart';
import 'package:al3la_restaurant/shared/adaptive/adaptive_indicator.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../drawer/admin_drawer.dart';

bool isLoadingPage = true;
String nameCategory = '';
GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getCategory(idUser: '$token');
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCategorySuccessStates) {
          isLoadingPage = false;
        }
        if (state is GetCategoryLoadingStates) {
          isLoadingPage = true;
        }
        if (state is GetCategoryErrorStates) {
          isLoadingPage = false;
          showToast(text: state.error, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: globalKey,
          appBar: AppBar(
            title: Column(
              children: [
                Text(
                  "${restaurantInformationModel?.name}",
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
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              navigateTo(context, AddCategoriesOrMeals());
            },
          ),
          drawer: const AdminDrawer(),
          body: (isLoadingPage == false)
              ? (HomeCubit.get(context).category.isEmpty)
                  ? const Center(child: Text("The categories is empty"))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: HomeCubit.get(context).category.length,
                      itemBuilder: (context, index) => categoryItem(
                          context, HomeCubit.get(context).category[index]))
              : Center(
                  child: AdaptiveIndicator(
                  os: getOs(),
                )),
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
        /* HomeCubit.get(context)
            .getMeal(idUser: '$token', category: categoryModel.uId);*/
        navigateTo(
            context,
            AddCategoriesOrMeals(
              categoryModel: categoryModel,
            ));
      },
      child: Container(
        color: Colors.white,
        child: Card(
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height *0.16,
                    // width:MediaQuery.of(context).size.width *0.85,
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(categoryModel.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialogDelete(
                          context: context,
                          function: () {
                            AddCubit.get(context).deleteCategory(
                                idUser: token!,
                                idCategory: categoryModel.uId,
                                context: context);
                          },
                          btnOkText:
                              getTranslated(context, "showDialog_OK_title"),
                          btnCancelText:
                              getTranslated(context, "showDialog_Cancel_title"),
                          title: categoryModel.name,
                          describe: getTranslated(context,
                              'category_page_body_showDialogDelete_dec'));
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
      ),
    ),
  );
}
