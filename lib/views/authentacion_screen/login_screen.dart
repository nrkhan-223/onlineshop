import 'package:online_app/views/authentacion_screen/signup_screen.dart';
import 'package:get/get.dart';
import '../../common_design/applogo_design.dart';
import '../../common_design/bg_common.dart';
import '../../common_design/common_button.dart';
import '../../common_design/common_textfild.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../controller/auth_controler.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

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
                13.heightBox,
                " Log in to $appname".text.white.size(20).semiBold.make(),
                20.heightBox,
                Obx(
                  ()=>Column(
                    children: [
                      5.heightBox,
                      commonTextField(hint: "Enter your email", title: "Email",ispass: false,controller:controller.emailController),
                      5.heightBox,
                      commonTextField(
                          hint: "Enter your password", title: "Password",ispass: true,controller: controller.passwordController),
                      10.heightBox,
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: "Forget password"
                                  .text
                                  .size(17)
                                  .fontFamily(semibold)
                                  .make())),
                      1.heightBox,
                     controller.loading.value?const CircularProgressIndicator(
                       valueColor:  AlwaysStoppedAnimation(redColor),
                     ): commonButton(
                          color: redColor,
                          title: "Login",
                          textColor: whiteColor,
                          onPress: ()async{
                            controller.loading(true);
                            await controller.loginMethod(context).then((value){
                              if(value!=null){

                                Get.offAll(()=>const Home());
                                controller.loading(false);
                                VxToast.show(context, msg: "login successfully");
                              }else{
                                controller.loading(false);
                                VxToast.show(context, msg: "Error Email Or Password");
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      "Or,Create a new account"
                          .text
                          .color(fontGrey)
                          .semiBold
                          .size(17)
                          .make(),
                      commonButton(
                          color: lightGolden,
                          title: "Signup",
                          textColor: redColor,
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          }).box.width(context.screenWidth - 50).make(),
                      7.heightBox,
                      "Log in with".text.semiBold.size(15).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 27,
                                    child: Image.asset(
                                      socialIconsList[index],
                                      width: 36,
                                    ),
                                  ),
                                )),
                      )

                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 65)
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
