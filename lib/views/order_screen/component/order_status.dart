import 'package:online_app/consts/consts.dart';

Widget orderStatus({icon, color, String? title, showDone,}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .padding(const EdgeInsets.all(4))
        .roundedSM
        .border(color: color).margin(const EdgeInsets.only(top: 10))
        .make(),
    subtitle: const Icon(Icons.horizontal_rule_outlined, color: darkFontGrey)
        .box
        .margin(const EdgeInsets.only(bottom: 10))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          title!.text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done_all,
                  color: Colors.green,
                )
              : Container(),
        ],
      ).box.margin(const EdgeInsets.only(top: 6)).make(),
    ),
  );
}
