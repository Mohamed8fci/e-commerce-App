import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/Network/endpoint.dart';
import 'package:news_app/NewsApp/Network/remote/dio_helper.dart';
import 'package:news_app/shopapp/register/cubit/state.dart';

import '../../models/login_models.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterIniatialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    String? name,
    String? email,
    String? password,
    String?  phone
})
  {
    emit(ShopRegisterLoadingState());
     DioHelper.postData(
       url: REGISTER,
       data: {
       'name': name,
         'email':email,
       'password':password,
         'phone':phone,
     },
     ).then((value) {
       print(value.data);
       loginModel= ShopLoginModel.fromJson(value.data);

       emit(ShopRegisterSuccsState(loginModel!));
     },).catchError((error){
        emit(ShopRegisterErrorState(error.toString()));
        print(error.toString());
     });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;
  void Changepasswordvisibality(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisiblityState());

  }
}