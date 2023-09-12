import 'package:get/get.dart';
import '../../common_design/applogo_design.dart';
import '../../common_design/bg_common.dart';
import '../../common_design/common_button.dart';
import '../../common_design/common_textfild.dart';
import '../../consts/consts.dart';
import '../../controller/auth_controler.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgCommon(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * .12).heightBox,
                applogoDesign(),
                10.heightBox,
                "Open an account on $appname"
                    .text
                    .white
                    .size(20)
                    .semiBold
                    .make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      commonTextField(
                        hint: "Enter your name",
                        ispass: false,
                        title: "Name",
                        controller: nameController,
                      ),
                      5.heightBox,
                      commonTextField(
                          hint: "Enter your email",
                          ispass: false,
                          title: "Email",
                          controller: emailController),
                      5.heightBox,
                      commonTextField(
                          hint: "Enter your password",
                          ispass: true,
                          title: "Password",
                          controller: passwordController),
                      5.heightBox,
                      commonTextField(
                          hint: "Enter same password here",
                          ispass: true,
                          title: "Retype password",
                          controller: passwordRetypeController),
                      5.heightBox,
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: "Forget password"
                                  .text
                                  .size(17)
                                  .fontFamily(semibold)
                                  .make())),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: redColor,
                              checkColor: whiteColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue!;
                                });
                              }),
                          7.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: "Terms and Conditions ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: bold,
                                      color: redColor,
                                    )),
                                TextSpan(
                                    text: "&",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: " Privacy Policy",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: bold,
                                      color: redColor,
                                    )),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      controller.loading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : commonButton(
                              color: isCheck ? redColor : lightGrey,
                              title: "Signup",
                              textColor: whiteColor,
                              onPress: () async {
                                String password =
                                    passwordController.value.toString();
                                String password2 =
                                    passwordRetypeController.value.toString();
                                if (nameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  if (password == password2) {
                                    if (isCheck != false) {
                                      try {
                                        controller.loading(true);
                                        await controller
                                            .signupMethod(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                context: context)
                                            .then((value) {
                                          return controller.storeUserData(
                                              name: nameController.text,
                                              password: passwordController.text,
                                              email: emailController.text);
                                        }).then((value) {
                                          VxToast.show(context,
                                              msg: "login successfully");
                                          Get.offAll(() => const Home());
                                        });
                                      } catch (e) {
                                        controller.loading(false);
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                      }
                                    }
                                  } else {
                                    VxToast.show(context,
                                        msg: "Password Error");
                                  }
                                } else {
                                  VxToast.show(context, msg: "Please Fill The Form Correctly");
                                }
                              }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Already have an account?"
                              .text
                              .bold
                              .color(fontGrey)
                              .make(),
                          5.widthBox,
                          "Login"
                              .text
                              .bold
                              .color(redColor)
                              .size(16)
                              .make()
                              .onTap(() {
                            Get.back();
                          })
                        ],
                      )
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 60)
                      .shadowSm
                      .make(),
                ),
                20.heightBox,
                "test app by NR".text.semiBold.make()
              ],
            ),
          )),
    );
  }
}
