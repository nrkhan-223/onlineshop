import 'package:online_app/common_design/common_button.dart';
import 'package:online_app/common_design/common_textfild.dart';
import 'package:online_app/consts/consts.dart';
import 'package:online_app/controller/cart_controller.dart';
import 'package:online_app/views/cart_screen/payment_method.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.semiBold.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: commonButton(
            color: redColor,
            textColor: whiteColor,
            title: "Continue",
            onPress: () {
              if (controller.addressCont.text.length > 10 &&
                  controller.postalCont.text.isNotEmpty &&
                  controller.cityCont.text.isNotEmpty &&
                  controller.stateCont.text.isNotEmpty &&
                  controller.phoneCont.text.isNotEmpty) {
                Get.to(() => const PaymentMethod());

              } else {
                VxToast.show(context, msg: "Please Fill The Form Correctly");
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            commonTextField(
                hint: "Address",
                ispass: false,
                title: "Address",
                controller: controller.addressCont),
            commonTextField(
                hint: "City",
                ispass: false,
                title: "City",
                controller: controller.cityCont),
            commonTextField(
                hint: "State",
                ispass: false,
                title: "State",
                controller: controller.stateCont),
            commonTextField(
                hint: "Phone",
                ispass: false,
                title: "Phone",
                controller: controller.phoneCont),
            commonTextField(
                hint: "Postal",
                ispass: false,
                title: "Postal",
                controller: controller.postalCont),
          ],
        ),
      ),
    );
  }
}
