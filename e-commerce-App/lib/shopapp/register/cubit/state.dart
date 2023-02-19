import 'package:news_app/shopapp/models/login_models.dart';

abstract class ShopRegisterStates{}

class ShopRegisterIniatialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccsState extends ShopRegisterStates{
   ShopLoginModel? loginModel;
   ShopRegisterSuccsState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String? error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisiblityState extends ShopRegisterStates{}