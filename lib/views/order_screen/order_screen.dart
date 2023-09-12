import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_app/common_design/loading_design.dart';
import 'package:online_app/consts/consts.dart';
import 'package:online_app/services/fiirestore_services.dart';
import 'package:get/get.dart';

import 'order_detals_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Order".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrder(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: "No Order Yet".text.semiBold.color(darkFontGrey).make());
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}".text.bold.color(darkFontGrey).xl.make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(()=> OrderDetails(data: data[index]));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: darkFontGrey,
                      )), // Icon // IconButton
                ); // ListTile
              },
            );
          }
        },
      ),
    );
  }
}
