import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_app/common_design/common_button.dart';
import 'package:online_app/common_design/loading_design.dart';
import 'package:online_app/services/fiirestore_services.dart';
import 'package:online_app/views/cart_screen/shiping_screen.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Cart".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              controller.totalprice.value = 0;
              return Center(
                child: "Cart Is Empty"
                    .text
                    .semiBold
                    .color(darkFontGrey)
                    .size(17)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (X${data[index]['qty']})"
                                          .text
                                          .size(16)
                                          .semiBold
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .semiBold
                                      .color(redColor)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                    size: 30,
                                  ).onTap(() {
                                    FireStoreServices.deleteCart(
                                        data[index].id);
                                  }));
                            })),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price:".text.semiBold.color(darkFontGrey).make(),
                        Obx(() => "${controller.totalprice.value}"
                            .numCurrency
                            .text
                            .semiBold
                            .color(redColor)
                            .make()),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(11))
                        .width(context.screenWidth - 20)
                        .color(lightGolden)
                        .roundedSM
                        .make(),
                  ],
                ),
              );
            }
          }),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: commonButton(
            color: redColor,
            title: "Buy",
            textColor: whiteColor,
            onPress: () {
              if (controller.totalprice.value == 0) {
                VxToast.show(context, msg: "cart is empty");
              } else {
                Get.to(() => const ShippingDetails());
              }
            }),
      ),
    );
  }
}
