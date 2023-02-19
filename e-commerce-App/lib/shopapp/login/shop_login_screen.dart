import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/NewsApp/Network/local/CacheHelper.dart';
import 'package:news_app/NewsApp/shared/components.dart';
import 'package:news_app/shopapp/ShopLayout.dart';
import 'package:news_app/shopapp/component/constant.dart';
import 'package:news_app/shopapp/login/cubit/cubit.dart';
import 'package:news_app/shopapp/login/cubit/state.dart';

import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);

   var formkey = GlobalKey<FormState>();

   var emailController = TextEditingController();
   var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccsState){
            if(state.loginModel.status)
            {

                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value){
                     Token = state.loginModel.data.token;
                   navigateAndFinish(context, ShopLayout(),
                );
                 });
            }else{
              print(state.loginModel.message);
             Showtoast(text: state.loginModel.message
                 , state: Toaststates.Erorr);

            }
          }
        },
        builder: (context, state) {
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
                        Text('Login',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),),
                        SizedBox(height: 20.0,),
                        Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.
                          copyWith(color: Colors.grey),),
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
                            if(formkey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validator: (String? value){
                            if(value!.isEmpty){
                              return "password is short";
                            }
                            return null;
                          },
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(labelText: "password",
                            prefix: Icon(Icons.lock),
    suffixIcon: IconButton(
    icon: Icon(
    // Based on passwordVisible state choose the icon
            ShopLoginCubit.get(context).suffix,
    ),
    onPressed: () {
    // Update the state i.e. toogle the state of passwordVisible variable
ShopLoginCubit.get(context).Changepasswordvisibality();
    }),

                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 25.0,
                        )
                        ,
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                            builder: (context)=>default_button(
                                Function: (){
                                  if(formkey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                },
                                text: 'Login',
                                isUpperCase: true),
                            fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text('Don\'t have an account?',),
                            defaultTextButton(
                              Function: () {
                                navigateTo(context, shop_register_screen());
                              },
                              text: 'register',
                            ),
                          ],
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
