import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';

import '../../styles/colors.dart';
import '../models/Favourites_model.dart';

class favouriteScreen extends StatelessWidget {
  const favouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouritesStates,
          builder: (context)=>ListView.separated(
              itemBuilder: (context, index) => BuildFavItem(ShopCubit.get(context).favouritesModel?.data?.data![index],context),
              separatorBuilder: (context, index) => SizedBox(height: 8.0,),
              itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length
          ),
          fallback: (context)=>Center(child:CircularProgressIndicator()),

        );
      },
    );
  }
  Widget BuildFavItem(FavouritesData? model,context) => Padding(

    padding: EdgeInsets.all(20.0),

    child:Container(

      height: 120.0,
  child:Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

  Stack(
  alignment: AlignmentDirectional.bottomStart,
  children:[
  Image(
  image: NetworkImage(model!.product!.image!),
  width: 120.0,
  height: 120.0,

  ),
  if(model.product!.discount! != 0)
  Container(
  color: Colors.red,
  padding: EdgeInsets.symmetric(horizontal: 5.0,),
  child: Text(
  'Discount',
  style: TextStyle(
  fontSize: 8.0,
  color: Colors.white,
  ),
  ),
  ),
  ],
  ),

  SizedBox(
  width: 20.0,
  ),
  Expanded(
  child:Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
    model.product!.name!,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
  fontSize: 14.0,
  height: 1.3,
  ),
  ),
  Spacer(),
  Row(
  children: [
  Text(
    model.product!.price.toString(),
  style: TextStyle(
  fontSize: 12.0,
  color: Colors.blue,
  ),
  ),
  SizedBox(width: 5.0,),
  if(model.product!.discount != 0)
  Text(
  model.product!.oldPrice.toString(),
  style: TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
  decoration: TextDecoration.lineThrough,
  ),
  ),
  Spacer(),
  IconButton(
  onPressed: (){
   ShopCubit.get(context).changeFavourites(model.product!.id!);
  },
  icon: CircleAvatar(
  radius: 15.0,
  backgroundColor: ShopCubit.get(context).favourites[model.product!.id]! ? defaultcolor : Colors.grey,
  child: Icon(
  Icons.favorite_border,
  size: 14.0,
  color: Colors.white,
  ),
  ),

  ),
  ],
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  );
}
