import 'package:flutter/material.dart';
import 'package:news_app/NewsApp/Network/local/CacheHelper.dart';
import 'package:news_app/NewsApp/shared/components.dart';
import 'package:news_app/shopapp/login/shop_login_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel{
  final String image,title,body;

  BordingModel({
    required this.image,
   required this.title,
   required this.body,
});
}
class OnBordingScreen extends StatefulWidget {

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var boardcontroller = PageController();

  List<BordingModel> bording=[
       BordingModel(image: 'assets/images/onbording1.jpg',
           title: 'on board title 1',
           body: 'on board body 1 '),
    BordingModel(image: 'assets/images/onbording.jpg',
        title: 'on board title 2',
        body: 'on board body 2'),
    BordingModel(image: 'assets/images/onbording2.jpg',
        title: 'on board title 3',
        body: 'on board body 3 '),
  ];

  bool islast = false;

  void submit(){
    CacheHelper.saveData(key: "onboarding", value: true).then((value) {
     if(value){
       navigateAndFinish(context, ShopLoginScreen());
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(Function:submit,
              text: ('Skip')),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                onPageChanged: (int index){
                  if(index == bording.length-1){
                    setState(() {
                      islast=true;
                    });
                    print('islast');
                  }else{
                    print('notlast');
                    setState(() {
                      islast=false;
                    });
                  }
                },
                itemBuilder: (context, index) => BuildBordingItem(bording[index]),
                itemCount: bording.length,
    ),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: bording.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultcolor,
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(islast){
                    submit();
                  }else{
                    boardcontroller.nextPage(duration: Duration(
                      milliseconds: 750,
                    ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget BuildBordingItem(BordingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(height: 30.0,),
      Text('${model.title}',style: TextStyle(fontSize: 24.0),),
      SizedBox(height: 14.0,),
      Text('${model.body}'),

    ],
  );
}
