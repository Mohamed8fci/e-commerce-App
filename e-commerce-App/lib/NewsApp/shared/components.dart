
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Modules/webview/webview_screen.dart';

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
        navigateTo(context, WebView_screen(article['url']));
  },
  child: Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text('${article['publishedAt']}',

                  style: TextStyle(color: Colors.grey),),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder(list,context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length >0,
  builder: (context)=>
      ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index) => buildArticleItem(list[index],context)
          , separatorBuilder:(context,index)=>Padding(padding: EdgeInsets.all(10.0),)
          , itemCount: 5),
  fallback: (context)=>isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> widget
  ),
);

void navigateAndFinish(
context,widget,
)=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>widget,
),

        (route) {
         return false;
        }
);

Widget default_button ({
double width = double.infinity ,
Color background = Colors.blue,
double height = 40.0,
required Function()? ,
required String text, required bool isUpperCase,

})=>
Container(
width: width,
height: height,
decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
color: background,

),

child: MaterialButton(
onPressed: Function,
child: Text(
text.toUpperCase(),
style: TextStyle(
color: Colors.white,
),
),
),
);

Widget defaultTextButton({
  required Function ()?,
  required String text,
}) =>TextButton(
  onPressed: Function,
  child: Text(text.toUpperCase()),
);

void Showtoast({
  required String text,
  required Toaststates state,
}) => Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: choseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum Toaststates{Sucess,Erorr,Warning}

Color? choseToastColor(Toaststates state){

  Color color;
  switch(state){
    case Toaststates.Sucess:
      color = Colors.green;
      break;
      case Toaststates.Erorr:
      color = Colors.red;
      break;
      case Toaststates.Warning:
      color = Colors.amber;
      break;
  }
   return color;
}