import 'package:get/get.dart';
import 'package:online_app/views/categories_screen/categories_details.dart';

import '../consts/consts.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .outerShadowSm
      .width(200)
      .padding(const EdgeInsets.all(4))
      .margin(const EdgeInsets.symmetric(horizontal: 5))
      .make()
      .onTap(() {
    Get.to(() => CategoriesDetails(title: title));
  });
}
