import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';
import 'package:news_app/shopapp/models/categories_model.dart';

class catiogresScreen extends StatelessWidget {
  const catiogresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
        builder: (context, state) {
          return  ListView.separated(
              itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data![index]),
              separatorBuilder: (context, index) => SizedBox(width: 16.0,),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length);
        },
    );
  }

  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(16.0),
    child:Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(model.name!,
        style: TextStyle(fontWeight: FontWeight.bold
        ,fontSize: 20.0),),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
