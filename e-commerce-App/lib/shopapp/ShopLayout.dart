import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/shared/components.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';
import 'package:news_app/shopapp/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('elgelany'),
               actions: [
                 IconButton(
                   icon: Icon(Icons.search),
                   onPressed: (){
                     navigateTo(context, searchScreen());
                   },
                 ),
               ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.ChangeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'settings'),
              ],
            ),
          );
        },
    );
  }
}
