import 'dart:io';
import 'package:online_app/common_design/bg_common.dart';
import 'package:online_app/common_design/common_button.dart';
import 'package:online_app/common_design/common_textfild.dart';
import 'package:online_app/views/account_screen/account_screen.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgCommon(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.widthBox,
            10.heightBox,
            data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 70,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 70,
                        fit: BoxFit.cover,
                      ).box.clip(Clip.antiAlias).roundedFull.make()
                    : Image.file(
                        File(controller.profileImagePath.value),
                        width: 70,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            commonButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            const Divider(
              thickness: 2,
            ),
            20.heightBox,
            commonTextField(
                controller: controller.nameController,
                hint: "Name",
                title: "Name",
                ispass: false),
            10.heightBox,
            commonTextField(
                controller: controller.oldpassController,
                hint: "Password",
                title: "Old Password",
                ispass: true),
            10.heightBox,
            commonTextField(
                controller: controller.newpassController,
                hint: "Password",
                title: "New Password",
                ispass: true),
            15.heightBox,
            controller.loading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : commonButton(
                    color: redColor,
                    textColor: whiteColor,
                    title: "SAVE",
                    onPress: () async {
                      controller.loading(true);
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImgLink = data['imageUrl'];
                      }
                      if (controller.nameController.text.isNotEmpty &&
                          controller.newpassController.text.isEmpty &&
                          controller.oldpassController.text.isEmpty) {
                        await controller
                            .updateName(
                                name: controller.nameController.text,
                                imgUrl: controller.profileImgLink)
                            .then((value) {
                          VxToast.show(context, msg: "Successfully changed");
                          Get.to(() => const AccountScreen());
                        });
                      } else if (controller.nameController.text.isEmpty &&
                          controller.newpassController.text.isNotEmpty &&
                          controller.oldpassController.text.isNotEmpty) {
                        if (data['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text);

                          await controller
                              .updateProfile(
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text,
                                  imgUrl: controller.profileImgLink)
                              .then((value) {
                            VxToast.show(context, msg: "Successfully changed");
                            Get.to(() => const AccountScreen());
                          });
                        } else {
                          VxToast.show(context, msg: "Wrong Password");
                          controller.loading(false);
                        }
                      }
                    }).box.width(context.screenWidth - 50).make(),
          ],
        )
            .box
            .color(Vx.gray100)
            .roundedSM
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.all(20))
            .make(),
      ),
    ));
  }
}
