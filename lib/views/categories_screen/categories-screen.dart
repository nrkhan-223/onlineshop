import 'package:onlineshop/controller/product_controller.dart';
import 'package:get/get.dart';

import '../../common_design/bg_common.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import 'categories_details.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgCommon(
        child: Scaffold(
      appBar: AppBar(title: "Categories".text.fontFamily(bold).make()),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .fontFamily(bold)
                      .make()
                ],
              )
                  .box
                  .white
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .roundedSM
                  .padding(const EdgeInsets.all(10))
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(() => CategoriesDetails(title: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
