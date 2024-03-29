import 'package:flutter/material.dart';

class StylesUtils {
  static UnderlineInputBorder textFieldUnderlineBorder = UnderlineInputBorder(
    borderSide: const BorderSide(
      color: ColorsUtils.textFieldBorderColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  static OutlineInputBorder textFieldOutsideBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey, width: 1.2),
    borderRadius: BorderRadius.circular(10.0),
  );
}

class ColorsUtils {

  static const Color textFieldBorderColor = Color(0xffF78C26);
  static const Color textFieldActiveIconColor = Color(0xff4E9CC2);

}