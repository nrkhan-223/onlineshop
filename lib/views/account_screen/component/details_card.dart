

import '../../../consts/consts.dart';

Widget detailsCard({width, String? count,String? title}){
  return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          count!.text.bold.color(darkFontGrey).size(15).make(),
          5.heightBox,
          title!.text.size(13).color(darkFontGrey).makeCentered()
        ],
      ).box.white.rounded.width(width).height(68).padding(const EdgeInsets.all(5)).make();
}
