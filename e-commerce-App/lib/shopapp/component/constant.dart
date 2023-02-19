import 'package:news_app/NewsApp/shared/components.dart';

import '../../NewsApp/Network/local/CacheHelper.dart';
import '../login/shop_login_screen.dart';

void sinout(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String Token = '';