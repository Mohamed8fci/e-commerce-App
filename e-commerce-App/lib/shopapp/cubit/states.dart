import 'package:news_app/shopapp/models/ChangeFavouritesModel.dart';
import 'package:news_app/shopapp/models/login_models.dart';

abstract class ShopStates{}

class ShopinitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErorrHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErorrCategoriesStates extends ShopStates{}

class ShopSuccessChangeFavouriteStates extends ShopStates{
  final ChangeFavouriteModel model;
  ShopSuccessChangeFavouriteStates(this.model);
}

class ShopErorrChangeFavouriteStates extends ShopStates{}

class ShopChangeFavouriteStates extends ShopStates{}

class ShopLoadingGetFavouritesStates extends ShopStates{}

class ShopSuccessGetFavouritesStates extends ShopStates{}

class ShopErorrGetFavouritesStates extends ShopStates{}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataStates(this.loginModel);
}

class ShopErorrUserDataStates extends ShopStates{}

class ShopLoadingUpdateStates extends ShopStates{}

class ShopSuccessUpdateStates extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateStates(this.loginModel);
}

class ShopErorrUpdateStates extends ShopStates{}