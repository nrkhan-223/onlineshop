import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:online_app/common_design/loading_design.dart';
import 'package:online_app/consts/consts.dart';
import 'package:online_app/services/fiirestore_services.dart';
import 'package:online_app/views/chat_screen/chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Messages".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: LoadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: "No Massage"
                .text
                .semiBold
                .color(darkFontGrey)
                .make());
          } else {
            var data=snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context,int index){

                      return Card(
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>const ChatScreen(),arguments: [data[index]['friend_name'],data[index]['toId']]);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: redColor,
                            child: Icon(Icons.person,color: Colors.white,),
                          ),

                          title: "${data[index]['friend_name']}".text.color(darkFontGrey).semiBold.make(),
                          subtitle: "${data[index]['last_msg']}".text.color(darkFontGrey).make(),
                        ),
                      );
                    },


                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
