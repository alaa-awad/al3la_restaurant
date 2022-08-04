
abstract class AddStates{}

class InitAddStates extends AddStates{}

class AddCategoryLoadingStates extends AddStates{}
class AddCategorySuccessStates extends AddStates{}
class AddCategoryErrorStates extends AddStates{
  final String error;
  AddCategoryErrorStates(this.error);
}

class UpdateCategoryLoadingStates extends AddStates{}
class UpdateCategorySuccessStates extends AddStates{}
class UpdateCategoryErrorStates extends AddStates{
  final String error;
  UpdateCategoryErrorStates(this.error);
}

class CategoryImagePickedSuccessState extends AddStates{}
class CategoryImagePickedErrorState extends AddStates{}


class ChangeCategoryStates extends AddStates{}


// all states for meals
class AddMealLoadingStates extends AddStates{}
class AddMealSuccessStates extends AddStates{}
class AddMealErrorStates extends AddStates{
  final String error;
  AddMealErrorStates(this.error);
}

// meal image state
class MealImagePickedSuccessState extends AddStates{}
class MealImagePickedErrorState extends AddStates{}

// update meal states
class UpdateMealLoadingStates extends AddStates{}
class UpdateMealSuccessStates extends AddStates{}
class UpdateMealErrorStates extends AddStates{
  final String error;
  UpdateMealErrorStates(this.error);
}