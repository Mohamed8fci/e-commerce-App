import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/Network/endpoint.dart';
import 'package:news_app/NewsApp/Network/remote/dio_helper.dart';
import 'package:news_app/shopapp/catigory/catgoriesScreen.dart';
import 'package:news_app/shopapp/component/constant.dart';
import 'package:news_app/shopapp/cubit/states.dart';
import 'package:news_app/shopapp/fovurites/favouriteScreen.dart';
import 'package:news_app/shopapp/models/Favourites_model.dart';
import 'package:news_app/shopapp/models/categories_model.dart';
import 'package:news_app/shopapp/models/home_model.dart';
import 'package:news_app/shopapp/product/productScreen.dart';
import 'package:news_app/shopapp/settings/settingtScreen.dart';

import '../models/ChangeFavouritesModel.dart';
import '../models/login_models.dart';

class ShopCubit extends Cubit <ShopStates>{
    ShopCubit() :super(ShopinitialStates());

    static ShopCubit get(context) => BlocProvider.of(context);

    int currentIndex= 0;

    List<Widget> bottomScreens = [
        productScreen(),
        catiogresScreen(),
        favouriteScreen(),
        settingtScreen(),
    ];

    void ChangeBottom(int index){
     currentIndex = index;
     emit(ShopChangeBottomNavStates());
}

HomeModel? homeModel;

    Map<int,bool> favourites = {};

void getHomeData(){
        emit(ShopLoadingHomeDataStates());
        DioHelper.getData(
            url: Home,
          token: Token,
        ).then((value) {
            homeModel = HomeModel.fromJson(value.data);
           //printFullText(homeModel?.data?.banners?[0].image?);
           // print(homeModel?.status);
            homeModel?.data?.products?.forEach((element) {
              favourites.addAll({
                element.id!: element.inFavorites!,
              });
            });
            print(favourites.toString());
            emit(ShopSuccessHomeDataStates());
        }).catchError((error){
               print(error);
           emit(ShopErorrHomeDataStates());
        });
}


    CategoriesModel? categoriesModel;

    void getcategoriesData(){
      DioHelper.getData(
        url: GET_GATEGORIES,
        token: Token,
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesStates());
        print(value.data.toString());
      }).catchError((error) {
        print(error.toString());
        emit(ShopErorrCategoriesStates());
      });
    }

    ChangeFavouriteModel? changeFavouriteModel;

    void changeFavourites(int productId){
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavouriteStates());

      DioHelper.postData(
          url: FAVORITES,
          data:{
            'product_id': productId,
          }
      ,token: Token)
          .then((value) {
            changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
            print(value.data);
            if(!changeFavouriteModel!.status!){
              favourites[productId] = !favourites[productId]!;
            }else{
              getFavouritesData();
            }
            emit(ShopSuccessChangeFavouriteStates(changeFavouriteModel!));
      }).catchError((error){
        favourites[productId] = !favourites[productId]!;
        emit(ShopErorrChangeFavouriteStates());
          });

    }


    Favourites_model? favouritesModel;

    void getFavouritesData(){
      emit(ShopLoadingGetFavouritesStates());
      DioHelper.getData(
        url: FAVORITES,
        token: Token,
      ).then((value) {
        favouritesModel = Favourites_model.fromJson(value.data);
        printFullText(value.data.toString());
        emit(ShopSuccessGetFavouritesStates());

      }).catchError((error) {
        print(error.toString());
        emit(ShopErorrGetFavouritesStates());
      });
    }


    ShopLoginModel? userModel;

    void getUserData(){
      emit(ShopLoadingUserDataStates());
      DioHelper.getData(
        url: PROFILE,
        token: Token,
      ).then((value) {
        userModel = ShopLoginModel.fromJson(value.data);
       printFullText(userModel!.data.name);
        emit(ShopSuccessUserDataStates(userModel!));

      }).catchError((error) {
        print(error.toString());
        emit(ShopErorrUserDataStates());
      });
    }

    void updateUserData({
      required String name,
      required String email,
      required String phone,
})
    {

      emit(ShopLoadingUpdateStates());
      DioHelper.putData(
        url: UPDATE_PROFILE,
        token: Token,
        data: {
          'name': name,
          'email' : email,
          'phone' : phone,
        },
      ).then((value) {
        userModel = ShopLoginModel.fromJson(value.data);
        printFullText(userModel!.data.name);
        emit(ShopSuccessUpdateStates(userModel!));

      }).catchError((error) {
        print(error.toString());
        emit(ShopErorrUpdateStates());
      });
    }
}