import 'package:onlineshop/views/order_screen/component/order_place_details.dart';
import 'package:onlineshop/views/order_screen/component/order_status.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/consts.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Order Details".text.color(darkFontGrey).semiBold.make(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Pleased",
                  showDone: data['order_place']),
              5.heightBox,
              orderStatus(
                  color: Colors.blueAccent,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']),
              5.heightBox,
              orderStatus(
                  color: Colors.green,
                  icon: Icons.delivery_dining_sharp,
                  title: "On Deliver",
                  showDone: data['order_on_delivery']),
              5.heightBox,
              orderStatus(
                  color: Colors.purpleAccent,
                  icon: Icons.done_all,
                  title: "Deliver",
                  showDone: data['order_delivered']),
              const Divider(thickness: 1.4,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    orderPlaceDetails(
                        d1: data['order_code'],
                        d2: data['shipping_method'],
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data['order_date'].toDate())),
                        d2: data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment Method"),
                    orderPlaceDetails(
                        d1: "UnPaid",
                        d2: "OrderPlaced",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              2.heightBox,
                              "${data['order_by_name']}".text.make(),
                              "${data['order_by_email']}".text.make(),
                              "${data['order_by_address']}".text.make(),
                              "${data['order_by_city']}".text.make(),
                              "${data['order_by_state']}".text.make(),
                              "${data['order_by_phone']}".text.make(),
                              "${data['order_by_postal']}".text.make()
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                20.heightBox,
                                Row(
                                  children: [
                                    "\$".text.color(redColor).bold.make(),
                                    "${data['total_amount']}"
                                        .numCurrency
                                        .text
                                        .bold
                                        .color(redColor)
                                        .make()
                                  ],
                                ),
                                76.heightBox,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).box.outerShadowMd.white.make(),
              ),
              const Divider(),
              10.heightBox,
              "Order Product"
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .size(15)
                  .make(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network("${data['orders'][index]['img']}",width: 70,height: 40,fit: BoxFit.cover,),
                                "${data['orders'][index]['title']}".text.semiBold.color(darkFontGrey).make(),
                                "${data['orders'][index]['qty']}X".text.semiBold.color(Colors.red).make(),
                              ],
                            ),
                            SizedBox(width: 120,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    "\$".text.color(redColor).bold.make(),"${data['orders'][index]['tprice']}".numCurrency.text.semiBold.color(darkFontGrey).make(),
                                  ],),
                                  "Refundable".text.semiBold.color(Colors.red).make(),

                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ).box.outerShadowMd.white.make(),
              30.heightBox,

            ],
          ),
        ));
  }
}
