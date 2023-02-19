import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shopapp/ShopLayout.dart';
import 'package:news_app/shopapp/component/constant.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';
import 'package:news_app/shopapp/login/shop_login_screen.dart';
import 'package:news_app/shopapp/onbording/onbording_screen.dart';
import 'package:news_app/styles/theme.dart';
import 'NewsApp/Network/local/CacheHelper.dart';
import 'NewsApp/Network/remote/dio_helper.dart';
import 'NewsApp/bloc/bloc.dart';
import 'NewsApp/bloc/states.dart';
import 'NewsApp/compnent/shared/bloc_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  //bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onboarding = CacheHelper.getData(key: 'onboarding');
  //Token = CacheHelper.getData(key: 'Token').isNotEmpty;

  if (onboarding != null) {
    if (Token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBordingScreen();
  }
  runApp(home((widget)));
}

class home extends StatelessWidget {
  // final bool isDark;
  final Widget startWidget;
  home(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getSciences()),
        // BlocProvider(create: (context)=> NewsCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getcategoriesData()
              ..getFavouritesData()
              ..getUserData()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
