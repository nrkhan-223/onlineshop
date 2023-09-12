import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_app/common_design/loading_design.dart';
import 'package:online_app/consts/consts.dart';
import 'package:online_app/services/fiirestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Wish List".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getWishList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: "Wish List Is Empty"
                .text
                .semiBold
                .color(darkFontGrey)
                .make());
          } else {
            var data=snapshot.data!.docs;
            return Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(

                          leading: Image.network("${data[index]['p_img'][0]}",width: 90,fit: BoxFit.cover,),
                          title: "${data[index]['p_name']}"
                              .text
                              .size(16)
                              .semiBold
                              .make(),
                          subtitle: "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .semiBold
                              .color(redColor)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                            size: 30,
                          ).onTap(() {
                            FireStoreServices.deleteWishlist(data[index].id);
                          })
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
