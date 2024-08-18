import 'package:get/get.dart';
import '../../common_design/common_button.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../controller/product_controller.dart';
import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic productdetail;

  const ItemDetails({super.key, required this.title, this.productdetail});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          controller.resetValue();
          return;
        }
      },

      //     () async {
      //   controller.resetValue();
      //   return true;
      // },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.resetValue();
              Get.back();
            },
          ),
          title: title.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: darkFontGrey,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(productdetail.id, context);
                    } else {
                      controller.addToWishlist(productdetail.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        enlargeCenterPage: true,
                        height: 340,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        viewportFraction: 0.8,
                        itemCount: productdetail['p_img'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            productdetail['p_img'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ).box.roundedSM.clip(Clip.antiAlias).make();
                        }),
                    15.heightBox,
                    title.text
                        .fontFamily(bold)
                        .size(22)
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(productdetail['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        "\$".text.semiBold.size(18).make(),
                        2.widthBox,
                        "${productdetail['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(18)
                            .make()
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller"
                                .text
                                .white
                                .fontFamily(semibold)
                                .size(14)
                                .make(),
                            4.heightBox,
                            "${productdetail['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                            arguments: [
                              productdetail['p_seller'],
                              productdetail['vendor_id']
                            ],
                          );
                        }),
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 15))
                        .color(textfieldGrey)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    productdetail['p_colors'].length,
                                    (index) => Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(productdetail[
                                                        'p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: const Icon(Icons.done,
                                                  color: fontGrey),
                                            )
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quality: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.totalPriceCalculate(
                                              int.parse(
                                                  productdetail['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(int.parse(
                                              productdetail['p_quantity']));
                                          controller.totalPriceCalculate(
                                              int.parse(
                                                  productdetail['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.heightBox,
                                    "(${productdetail['p_quantity']} available)"
                                        .text
                                        .fontFamily(semibold)
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .bold
                                  .size(16)
                                  .make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      )
                          .box
                          .white
                          .roundedSM
                          .margin(const EdgeInsets.all(10))
                          .shadowSm
                          .make(),
                    ),
                    10.heightBox,
                    "Description"
                        .text
                        .size(18)
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5-.0),
                      child: "${productdetail['p_descriptions']} "
                          .text
                          .size(14.5)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    ),
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemButtonList.length,
                          (index) => ListTile(
                                title: itemButtonList[index]
                                    .text
                                    .semiBold
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    15.heightBox,
                    "Product You May Like"
                        .text
                        .bold
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    15.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP3,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              5.heightBox,
                              "test product"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              "\$400"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(18)
                                  .make(),
                              10.heightBox,
                            ],
                          )
                              .box
                              .height(context.screenHeight*0.23)
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .roundedSM
                              .padding(const EdgeInsets.all(5))
                              .make(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              width: context.screenWidth*0.95,
              height: 60,
              child: commonButton(
                  color: redColor,
                  title: "Add to cart",
                  textColor: whiteColor,
                  onPress: () {
                    if (controller.quantity.value == 0) {
                      VxToast.show(context, msg: "Please Increase Quantity");
                    } else {
                      controller.addToCart(
                          context: context,
                          color: productdetail['p_colors']
                              [controller.colorIndex.value],
                          vendorId: productdetail['vendor_id'],
                          img: productdetail['p_img'][0],
                          qty: controller.quantity.value,
                          sellername: productdetail['p_seller'],
                          title: productdetail['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added To Cart");
                    }
                  }),
            ),
            10.heightBox
          ],
        ),
      ),
    );
  }
}
