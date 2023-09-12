import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:online_app/views/account_screen/profile_edit.dart';
import '../../common_design/bg_common.dart';
import '../../common_design/loading_design.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../controller/auth_controler.dart';
import '../../controller/profile_controller.dart';
import '../../services/fiirestore_services.dart';
import '../Wishlist_screen/wishlist_screen.dart';
import '../authentacion_screen/login_screen.dart';
import '../chat_screen/message_screen.dart';
import '../order_screen/order_screen.dart';
import 'component/details_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgCommon(
        child: Scaffold(
          body: StreamBuilder(
              stream: FireStoreServices.getUser(currentUser!.uid),
              builder:
                  (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];

                  return SafeArea(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: whiteColor,
                          ),
                        ).onTap(() {
                          controller.nameController.text = data['name'];
                          Get.to(() =>
                              EditProfileScreen(
                                data: data,
                              ));
                        }),
                        Row(

                          children: [
                            5.widthBox,
                            data['imageUrl'] == ''
                                ?
                            Image
                                .asset(
                              imgProfile2,
                              width: 90,
                              fit: BoxFit.cover,
                            )
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                                : Image
                                .network(
                              data['imageUrl'],
                              width: 75,
                              fit: BoxFit.cover,
                            )
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                            5.widthBox,
                            Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    15.heightBox,
                                    "${data['name']}".text.semiBold.white
                                        .make(),
                                    8.heightBox,
                                    "${data['email']}".text.white.make()
                                  ],
                                )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context);
                                  VxToast.show(
                                      context, msg: "logout successfully");
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: "Logout".text.semiBold.white.make())
                          ],
                        ).box.height(70).make(),
                        20.heightBox,
                        FutureBuilder(
                            future: FireStoreServices.getCount(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: LoadingIndicator(),);
                              } else {
                                var countData=snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    detailsCard(count:countData[0].toString() ,title:"In Your Cart" ,width:context.screenWidth/3.4 ),
                                    detailsCard(count:countData[1].toString() ,title:"In Your Wishlist" ,width:context.screenWidth/3.4 ),
                                    detailsCard(count:countData[2] .toString(),title: "In Your Order",width: context.screenWidth/3.4)
                                  ],
                                );
                              }
                            }),
                        24.heightBox,
                        Column(
                          children: [
                            ListView
                                .separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const OrderScreen());
                                          break;
                                        case 1:
                                          Get.to(() => const WishlistScreen());
                                          break;
                                        case 2:
                                          Get.to(() => const MessageScreen());
                                          break;
                                      }
                                    },
                                    leading: Image.asset(
                                      profileButtonIcons[index],
                                      width: 20,
                                    ),
                                    title: profileButtonList[index]
                                        .text
                                        .bold
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 10,
                                    thickness: 2,
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonList.length)
                                .box
                                .white
                                .rounded
                                .padding(
                                const EdgeInsets.symmetric(horizontal: 15))
                                .shadowSm
                                .make(),
                          ],
                        )
                            .box
                            .color(redColor)
                            .height(220)
                            .padding(const EdgeInsets.all(8))
                            .make()
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
