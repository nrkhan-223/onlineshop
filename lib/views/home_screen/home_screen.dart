import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/home_controler.dart';
import 'package:onlineshop/views/categories_screen/item_details.dart';
import 'package:onlineshop/views/home_screen/search_screen.dart';
import '../../common_design/common_button2.dart';
import '../../common_design/feature_button.dart';
import '../../common_design/loading_design.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../controller/product_controller.dart';
import '../../services/fiirestore_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller2= Get.put(ProductController());
    var controller=Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(11),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if(controller.searchController.text.isNotEmptyAndNotNull){
                      Get.to(()=>SearchScreen(title: controller.searchController.text,));

                    }else{
                      VxToast.show(context, msg: "Search Box Is Empty");
                    }
                    //controller.searchController.clear();
                  }),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: "Search here...",
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ).box.outerShadow.make(),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        enlargeCenterPage: true,
                        height: 140,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        itemCount: brandsListSlider.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            brandsListSlider[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => commonButton2(
                              height: context.screenHeight * .13,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title:
                                  index == 0 ? "Today's Deal" : "Flash Sale")),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                        enlargeCenterPage: true,
                        height: 140,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        itemCount: brandsListSlider2.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            brandsListSlider2[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => commonButton2(
                              height: context.screenHeight * .123,
                              width: context.screenWidth / 3.42,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? "Top Categories"
                                  : index == 1
                                      ? "Brands"
                                      : "Top Sellers")),
                    ),
                    15.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "Feature Categories"
                          .text
                          .color(darkFontGrey)
                          .size(19)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    15.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featureButton(
                                        icon: featureImageList1[index],
                                        title: featureListTitles1[index]),
                                    10.heightBox,
                                    featureButton(
                                        icon: featureImageList2[index],
                                        title: featureListTitles2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),
                    15.heightBox,
                    Container(
                      padding: const EdgeInsets.all(9),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Feature Product"
                              .text
                              .fontFamily(semibold)
                              .size(18)
                              .white
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FireStoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: LoadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Product available"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featureData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                        featureData.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featureData[index]['p_img'][0],
                                              width: 160,
                                              fit: BoxFit.cover,
                                            ).box.roundedSM.clip(Clip.antiAlias).make(),
                                            5.heightBox,
                                            "${featureData[index]['p_name']}"
                                                .text
                                                .size(15)
                                                .semiBold
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            Row(
                                              children: [
                                                "\$"
                                                    .text
                                                    .semiBold
                                                    .size(18)
                                                    .make(),
                                                2.widthBox,
                                                "${featureData[index]['p_price']}"
                                                    .numCurrency
                                                    .text
                                                    .color(redColor)
                                                    .fontFamily(bold)
                                                    .size(18)
                                                    .make()
                                              ],
                                            ),
                                            10.heightBox,
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 5))
                                            .roundedSM
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemDetails(
                                                title:
                                                    "${featureData[index]['p_name']}",
                                                productdetail:
                                                    featureData[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    15.heightBox,
                    VxSwiper.builder(
                        enlargeCenterPage: true,
                        height: 140,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        itemCount: brandsListSlider.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            brandsListSlider[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .make();
                        }),
                    15.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: "All Products"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .size(19)
                            .make()),
                    15.heightBox,
                    StreamBuilder(
                        stream: FireStoreServices.allProduct(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: LoadingIndicator(),
                            );
                          } else {
                            var allproductdata = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allproductdata.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 2,
                                        mainAxisExtent: 220),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        allproductdata[index]['p_img'][0],
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ).box.roundedSM.clip(Clip.antiAlias).make(),
                                      10.heightBox,
                                      "${allproductdata[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          "\$".text.semiBold.size(18).make(),
                                          2.widthBox,
                                          "${allproductdata[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(18)
                                              .make(),
                                        ],
                                      ),
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 5))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(10))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allproductdata[index]['p_name']}",
                                          productdetail: allproductdata[index],
                                        ));
                                  });
                                });
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
