
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/shared/components.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';
import 'package:news_app/shopapp/models/categories_model.dart';
import 'package:news_app/shopapp/models/home_model.dart';
import 'package:news_app/styles/colors.dart';

class productScreen extends StatelessWidget {
  const productScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopSuccessChangeFavouriteStates){
           if(!state.model.status!){
             Showtoast(text: state.model.message!, state: Toaststates.Erorr);
           }
          }
        },
         builder: (context, state) {
           return ConditionalBuilder(
               condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
               builder: (context)=>BuilderWidget(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
               fallback: (context) =>Center(child: CircularProgressIndicator()),
           );
         },
    );
  }
  Widget BuilderWidget(HomeModel? model,CategoriesModel? categoriesModel,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
      child :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model?.data?.banners?.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              height: 100.0,
              child:ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>buildCateigoreyItem(categoriesModel.data!.data![index]),
                separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                itemCount: categoriesModel!.data!.data!.length,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),

      Container(
        color: Colors.grey[300],
     child: GridView.count(
          crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1/1.8,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
            model!.data!.products!.length,
                (index) =>buildGridProduct(model.data!.products![index],context),
        ),
      ),
      ),
    ],
  ),
  );
   Widget buildCateigoreyItem(DataModel model) => Stack(
     alignment: AlignmentDirectional.bottomCenter,
     children: [
       Image(
         image: NetworkImage(model.image!),
         width: 100.0,
         height: 100.0,
         fit: BoxFit.cover,
       ),
       Container(
         color: Colors.black.withOpacity(.8,),
         width: 100.0,
         child: Text(
           model.name!,
           textAlign: TextAlign.center,
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
           style: TextStyle(
             color: Colors.white,
           ),
         ),
       ),
     ],
   );
  Widget buildGridProduct(Products? model,context)=>
     Container(
       color: Colors.white,
      child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomStart,
      children:[
       Image(
  image: NetworkImage(model!.image!),
    width: double.infinity,
    fit: BoxFit.cover,
    height: 200.0,
  ),
        if(model.discount != 0)
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
      ]
    ),
    Padding(
  padding: const EdgeInsets.all(12.0),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.name!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.0,
            height: 1.3,
          ),
        ),
        Row(
          children: [
            Text(
              '${model.price.round()}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 5.0,),
            if(model.discount != 0)
            Text(
              '${model.oldPrice.round()}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: (){
                ShopCubit.get(context).changeFavourites(model.id!);
                print(model.id);
              },
              icon: CircleAvatar(
                radius: 15.0,
              backgroundColor: ShopCubit.get(context).favourites[model.id]! ? defaultcolor : Colors.grey,
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
  );
}
