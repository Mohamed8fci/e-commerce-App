import 'package:news_app/shopapp/models/login_models.dart';

abstract class ShopLoginStates{}

class ShopLoginIniatialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccsState extends ShopLoginStates{
   ShopLoginModel loginModel;
   ShopLoginSuccsState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisiblityState extends ShopLoginStates{}