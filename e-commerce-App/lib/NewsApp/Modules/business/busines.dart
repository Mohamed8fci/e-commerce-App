import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../bloc/states.dart';
import '../../shared/components.dart';


class Business_Layout extends StatelessWidget {
  const Business_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context, state) {},
      builder: (context, state) {

       var list = NewsCubit.get(context).business;
        return articleBuilder(list,context);
      }
    );
  }
}