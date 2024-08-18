import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../consts/consts.dart';
import '../models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];
  var colorIndex = 0.obs;
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var isFav=false.obs;
  var rowColor=0.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }
  changeRowColor(index){
    rowColor.value=index;
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  totalPriceCalculate(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice, context,vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'vendor_id':vendorId,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }
  resetValue2() {
    rowColor.value=0;
  }


  addToWishlist(docId,context)async{
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge:true));
    isFav(true);
    VxToast.show(context, msg:"Add To Wishlist");
  }

  removeFromWishlist(docId,context)async{
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge:true));
    isFav(false);
    VxToast.show(context, msg:"Remove From Wishlist");
  }

  checkIfFav(data)async{

  }


}
