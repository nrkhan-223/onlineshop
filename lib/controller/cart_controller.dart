import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import 'home_controler.dart';

class CartController extends GetxController {
  var totalprice = 0.obs;
  var addressCont = TextEditingController();
  var cityCont = TextEditingController();
  var stateCont = TextEditingController();
  var phoneCont = TextEditingController();
  var postalCont = TextEditingController();
  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var plasingOrder=false.obs;
 var vendors=[];

  calculate(data) {
    for (var i = 0; i < data.length; i++) {
      totalprice.value = 0;
      totalprice.value =
          totalprice.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  orderMethod({required orderPaymentMethod, required totalAmount}) async {
    plasingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by_id': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressCont.text,
      'order_by_state': stateCont.text,
      'order_by_city': cityCont.text,
      'order_by_phone': phoneCont.text,
      'order_by_postal': postalCont.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_place': true,
      'total_amount': totalAmount,
      'order_code': "13456780",
      'order_date': FieldValue.serverTimestamp(),
      'orders': FieldValue.arrayUnion(products),
      'order_confirmed': false,
      'order_delivered': false,
      'vendors':FieldValue.arrayUnion(vendors),
      'order_on_delivery': false,
    });
    plasingOrder(false);
    clearField();
  }

  getProductDetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'vendor_id':productSnapshot[i]['vendor_id'],
        'tprice':productSnapshot[i]['tprice'],
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

  clearField(){
   cityCont.clear(); addressCont.clear();stateCont.clear();phoneCont.clear();postalCont.clear();
  }
}
