import 'package:flutter/services.dart';
import '../consts/colors.dart';
import '../consts/consts.dart';
import 'common_button.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "CONFIRM".text.bold.size(18).color(darkFontGrey).make(),
        const Divider(
          thickness: 2,
        ),
        "Do you want to Exit?".text.bold.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            commonButton(color: redColor,textColor: whiteColor,title:"Yes",onPress: (){
              SystemNavigator.pop();
            }),
            commonButton(color: redColor,textColor: whiteColor,title:"no",onPress: (){
              Navigator.pop(context);
            }),
          ],
        )
      ],

    ).box.color(lightGrey).padding(const EdgeInsets.all(10)).roundedSM.make(),
  );
}