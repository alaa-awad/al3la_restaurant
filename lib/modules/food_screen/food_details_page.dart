import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/layout.dart';
import 'package:al3la_restaurant/models/meal.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
  final MealModule mealModule;
  const FoodDetailsPage({Key? key, required this.mealModule}) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image(
              image: NetworkImage(widget.mealModule.image),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.mealModule.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            '${widget.mealModule.price}\$',
            style: const TextStyle(
              fontSize: 17,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.mealModule.describe,
              style: const TextStyle(
                fontSize: 15,
                color: kTextColor,
              ),
            ),
          ),
          const Spacer(),
          if (workerModel != null)
            Row(
              children: <Widget>[
                SizedBox(
                  width: size.width / 2,
                  height: 84,
                  ///ToDo : Change flatButton to TextButton
                  child: FlatButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                      ),
                    ),
                    color: Colors.teal,
                    onPressed: () {
                      if (count > 0) {
                        HomeCubit.get(context).addOrder(
                            mealModule: widget.mealModule, count: count);
                        navigateAndFinish(context, const Layout());
                      }
                    },
                    child: Text(
                      getTranslated(
                          context, "food_details_page_button_addToMenu_text"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.teal,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(count.toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          if (count > 0) {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
