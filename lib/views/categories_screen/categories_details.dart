import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../common_design/bg_common.dart';
import '../../common_design/loading_design.dart';
import '../../consts/consts.dart';
import '../../controller/product_controller.dart';
import '../../services/fiirestore_services.dart';
import 'item_details.dart';

class CategoriesDetails extends StatefulWidget {
  final String title;

  const CategoriesDetails({super.key, required this.title});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

@override
class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreServices.getSubcategory(title);
    } else {
      productMethod = FireStoreServices.getProduct(title);
    }
  }
  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          controller.resetValue2();
          return;
        }
      },
      child: bgCommon(
          child: Scaffold(
        appBar: AppBar(
          title: widget.title.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .maxLines(1)
                            .fontFamily(semibold)
                            .color(fontGrey)
                            .makeCentered()
                            .box
                            .outerShadowLg
                            .color(controller.rowColor.value == index
                                ? Colors.yellow
                                : Colors.white)
                            .height(44)
                            .padding(const EdgeInsets.symmetric(horizontal: 10))
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          controller.changeRowColor(index);
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                          VxToast.show(context,
                              msg: "${controller.subcat[index]}");
                        })),
              ),
            ),
            50.heightBox,
            StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: LoadingIndicator(),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: "No Product Found"
                          .text
                          .color(darkFontGrey)
                          .size(17)
                          .makeCentered(),
                    );
                  } else {
                    var productdata = snapshot.data!.docs;
                    return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productdata.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 235),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  productdata[index]['p_img'][0],
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ).box.roundedSM.clip(Clip.antiAlias).make(),
                                "${productdata[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                Row(
                                  children: [
                                    "\$".text.semiBold.size(18).make(),
                                    2.widthBox,
                                    "${productdata[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(18)
                                        .make()
                                  ],
                                ),
                              ],
                            )
                                .box
                                .white
                                .outerShadowMd
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 5))
                                .roundedSM
                                .padding(const EdgeInsets.all(10))
                                .make()
                                .onTap(() {
                              controller.checkIfFav(productdata[index]);

                              Get.to(() => ItemDetails(
                                    title: "${productdata[index]['p_name']}",
                                    productdetail: productdata[index],
                                  ));
                            });
                          }),
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}
