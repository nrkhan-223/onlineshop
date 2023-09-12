

import '../consts/consts.dart';

Widget commonTextField({String? title,String? hint,controller,ispass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(15).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration:  InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,color: textfieldGrey,
          ),hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: redColor))),
      )
    ],
  );
}
