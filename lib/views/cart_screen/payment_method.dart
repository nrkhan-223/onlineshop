import 'package:onlineshop/common_design/loading_design.dart';
import 'package:onlineshop/consts/list.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/views/home_screen/home.dart';
import 'package:get/get.dart';
import '../../common_design/common_button.dart';
import '../../consts/consts.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title:
              "Chose Payment Method".text.semiBold.color(darkFontGrey).make(),
        ),
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        )),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 110,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.color
                              : BlendMode.darken,
                          color: controller.paymentIndex.value == index
                              ? Colors.transparent
                              : Colors.black.withOpacity(.4),
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: true,
                                  activeColor: Colors.green,
                                  onChanged: (value) {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              )
                            : Container(),
                        Positioned(
                            bottom: 5,
                            right: 3,
                            child: paymentMethodList[index]
                                .text
                                .size(16)
                                .bold
                                .color(Colors.black54)
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
          bottomNavigationBar: SizedBox(
            height: 40,
            child: controller.plasingOrder.value
                ? Center(
              child: LoadingIndicator(),
            )
                : commonButton(
                color: redColor,
                textColor: whiteColor,
                title: "Place Order",
                onPress: ()async {
                  controller.orderMethod(
                      orderPaymentMethod:
                      paymentMethodList[controller.paymentIndex.value],
                      totalAmount: controller.totalprice.value);
                  await controller.clearCart();
                  VxToast.show(context, msg:"Order Place Succesfullyt");
                  Get.offAll(const Home());
                }),
          )
      ),
    );
  }
}
