import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shopapp/register/cubit/cubit.dart';
import 'package:news_app/shopapp/register/cubit/state.dart';

import '../../NewsApp/Network/local/CacheHelper.dart';
import '../../NewsApp/shared/components.dart';
import '../ShopLayout.dart';
import '../component/constant.dart';

class shop_register_screen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccsState){
            if(state.loginModel!.status)
            {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data.token,
              ).then((value){
                Token = state.loginModel!.data.token;
                navigateAndFinish(context, ShopLayout(),
                );
              });
            }else{
              Showtoast(text: state.loginModel!.message
                  , state: Toaststates.Erorr);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),),
                        SizedBox(height: 20.0,),
                        Text('register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.
                          copyWith(color: Colors.grey),),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          controller: nameController,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return "name must be not empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "User Name",
                              prefix: Icon(Icons.person)
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          controller: emailController,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return "email must be not empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Email Adresses",
                              prefix: Icon(Icons.email)
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          onFieldSubmitted: (value){

                          },
                          validator: (String? value){
                            if(value!.isEmpty){
                              return "password is short";
                            }
                            return null;
                          },
                          obscureText: ShopRegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(labelText: "password",
                            prefix: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  ShopRegisterCubit.get(context).suffix,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  ShopRegisterCubit.get(context).Changepasswordvisibality() ;
                                }),

                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return "phone must be not empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Phone",
                              prefix: Icon(Icons.phone)
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 30.0,),

                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=>default_button(
                              Function: (){
                                if(formkey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'register',
                              isUpperCase: true),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
