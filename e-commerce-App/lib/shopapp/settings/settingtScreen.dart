import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/shared/components.dart';
import 'package:news_app/shopapp/component/constant.dart';
import 'package:news_app/shopapp/cubit/cubit.dart';
import 'package:news_app/shopapp/cubit/states.dart';

class settingtScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){
          if(state is ShopSuccessUserDataStates){
            nameController.text = state.loginModel.data.name;
            emailController.text = state.loginModel.data.email;
            phoneController.text = state.loginModel.data.phone;
          }
        },
      builder: (context, state) {
          var model = ShopCubit.get(context).userModel;

          nameController.text = model!.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;

       return ConditionalBuilder(
           condition: ShopCubit.get(context).userModel != null,
           builder: (context)=> Padding(
             padding: EdgeInsets.all(16.0),
             child:Form(
              key: formKey,
             child:Column(
               children: [
                 if(state is ShopLoadingUpdateStates)
                   LinearProgressIndicator(),
                 SizedBox(
                   height: 20.0,
                 ),
                 TextFormField(
                   controller: nameController,
                   validator: (String? value){
                     if(value!.isEmpty){
                       return "name must be not empty";
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                       labelText: "name",
                       prefix: Icon(Icons.person)
                   ),
                   keyboardType: TextInputType.name,
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 TextFormField(
                   controller: emailController,
                   validator: (String? value){
                     if(value!.isEmpty){
                       return "email must be not empty";
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                       labelText: "Email Address",
                       prefix: Icon(Icons.email)
                   ),
                   keyboardType: TextInputType.emailAddress,
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 TextFormField(
                   controller: phoneController,
                   validator: (String? value){
                     if(value!.isEmpty){
                       return "phone number must be not empty";
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                       labelText: "Phone Number",
                       prefix: Icon(Icons.phone_android)
                   ),
                   keyboardType: TextInputType.phone,
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 default_button(
                     Function: (){

                       if(formKey.currentState!.validate()){
                         ShopCubit.get(context).updateUserData(

                             name: nameController.text,
                             email: emailController.text,
                             phone: phoneController.text,
                         );
                       }

                 },
                     text: 'update', isUpperCase: true
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 default_button(Function: (){
                   sinout(context);
                 },
                     text: 'Logout', isUpperCase: true),
               ],
             ),
             ),
           ),
           fallback: (context)=>Center(child: CircularProgressIndicator()),
       );
      }
      );
  }
}
