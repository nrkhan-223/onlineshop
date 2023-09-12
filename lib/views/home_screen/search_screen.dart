import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:online_app/common_design/loading_design.dart';
import 'package:online_app/services/fiirestore_services.dart';

import '../../consts/consts.dart';
import '../categories_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: FutureBuilder(
          future: FireStoreServices.searchProducts(title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Products Found".text.semiBold.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filter=data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
             if(filter.isNotEmpty){
               return GridView(
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 8,
                     crossAxisSpacing: 2,
                     mainAxisExtent: 220),
                 children: filter
                     .mapIndexed((currentValue, index) => Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Image.network(
                       filter[index]['p_img'][0],
                       width: 200,
                       fit: BoxFit.cover,
                     ).box.roundedSM.clip(Clip.antiAlias).make(),
                     10.heightBox,
                     "${filter[index]['p_name']}"
                         .text
                         .fontFamily(semibold)
                         .color(darkFontGrey)
                         .make(),
                     10.heightBox,
                     Row(
                       children: [
                         "\$".text.semiBold.size(18).make(),
                         2.widthBox,
                         "${filter[index]['p_price']}"
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
                     .white.outerShadowMd
                     .margin(const EdgeInsets.symmetric(horizontal: 5))
                     .roundedSM
                     .padding(const EdgeInsets.all(10))
                     .make()
                     .onTap(() {
                   Get.to(() => ItemDetails(
                     title: "${filter[index]['p_name']}",
                     productdetail: filter[index],
                   ));
                 }))
                     .toList(),
               );
             }else{
               return "No Products Found".text.semiBold.makeCentered();
             }
            }
          }),
    );
  }
}
