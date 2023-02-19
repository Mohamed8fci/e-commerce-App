import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/Network/endpoint.dart';
import 'package:news_app/NewsApp/Network/remote/dio_helper.dart';
import 'package:news_app/shopapp/login/cubit/state.dart';

import '../../models/login_models.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginIniatialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,password
})
  {
    emit(ShopLoginLoadingState());
     DioHelper.postData(url: Login, data: {
       'email':email,
       'password':password,
     },
     ).then((value) {
       print(value.data);
       loginModel= ShopLoginModel.fromJson(value.data);

       emit(ShopLoginSuccsState(loginModel!));
     },).catchError((error){
        emit(ShopLoginErrorState(error.toString()));
     });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;
  void Changepasswordvisibality(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisiblityState());

  }
}