abstract class HomeState {}

class InitHomeCubit extends HomeState {}

// all state to User
class GetUserLoadingStates extends HomeState {}

class GetUserSuccessStates extends HomeState {}

class GetUserErrorStates extends HomeState {
  final String error;
  GetUserErrorStates(this.error);
}

class GetCategoryLoadingStates extends HomeState {}

class GetCategorySuccessStates extends HomeState {}

class GetCategoryErrorStates extends HomeState {
  final String error;
  GetCategoryErrorStates(this.error);
}

class GetMealLoadingStates extends HomeState {}

class GetMealSuccessStates extends HomeState {}

class GetMealErrorStates extends HomeState {
  final String error;
  GetMealErrorStates(this.error);
}

class ChangeCountOrderMeal extends HomeState {}

// all state to RestaurantInformation
class GetRestaurantInformationLoadingStates extends HomeState {}

class GetRestaurantInformationSuccessStates extends HomeState {}

class GetRestaurantInformationErrorStates extends HomeState {
  final String error;
  GetRestaurantInformationErrorStates(this.error);
}

// add Restaurant Information
class AddRestaurantInformationLoadingStates extends HomeState {}

class AddRestaurantInformationSuccessStates extends HomeState {}

class AddRestaurantInformationErrorStates extends HomeState {
  final String error;
  AddRestaurantInformationErrorStates(this.error);
}

//State for change language
class ChangeLanguageState extends HomeState {}


//State for change language
class ChangeTypeWorkerState extends HomeState {}

// States workers

//state get Worker
class GetWorkerLoadingStates extends HomeState {}

class GetWorkerSuccessStates extends HomeState {}

class GetWorkerErrorStates extends HomeState {
  final String error;
  GetWorkerErrorStates(this.error);
}

//state get workers
class GetWorkersLoadingStates extends HomeState {}

class GetWorkersSuccessStates extends HomeState {}

class GetWorkersErrorStates extends HomeState {
  final String error;
  GetWorkersErrorStates(this.error);
}

//state Update tablet
class UpdateWorkerLoadingStates extends HomeState {}

class UpdateWorkerSuccessStates extends HomeState {}

class UpdateWorkerErrorStates extends HomeState {
  final String error;
  UpdateWorkerErrorStates(this.error);
}

//state add tablet
class AddWorkerLoadingStates extends HomeState {}

class AddWorkerSuccessStates extends HomeState {}

class AddWorkerErrorStates extends HomeState {
  final String error;
  AddWorkerErrorStates(this.error);
}

// total price
class UpdateTotalPriceStates extends HomeState {}

//state get orders
class GetOrdersLoadingStates extends HomeState {}

class GetOrdersSuccessStates extends HomeState {}

class GetOrdersErrorStates extends HomeState {
  final String error;
  GetOrdersErrorStates(this.error);
}

//state add cart
class AddCartLoadingStates extends HomeState {}

class AddCartSuccessStates extends HomeState {}

class AddCartErrorStates extends HomeState {
  final String error;
  AddCartErrorStates(this.error);
}