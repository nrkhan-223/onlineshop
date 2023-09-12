import 'package:cloud_firestore/cloud_firestore.dart';

import '../consts/firebase_consts.dart';

class FireStoreServices {
  var index;

  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProduct(category) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
  static getSubcategory(title){
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteCart(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessage(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrder() {
    return firestore
        .collection(ordersCollection)
        .where('order_by_id', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishList() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static deleteWishlist(docId) {
    return firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
  }

  static getCount()async{
    var res =await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by_id', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allProduct(){
    return firestore.collection(productCollection).snapshots();

  }
  static getFeaturedProducts(){
    return firestore.collection(productCollection).where('is_featured',isEqualTo:true ).get(); }

  static searchProducts(title){
    return firestore.collection(productCollection).get();
  }
}
