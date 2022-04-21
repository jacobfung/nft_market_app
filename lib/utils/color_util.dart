import 'package:flutter/cupertino.dart';

class ColorUtil {
  static Color hexColor(String hex) {
    return Color(int.parse('0xff$hex'));
  }

  static Color commonGrey() {
    return hexColor('8d98af');
  }

  static Color commonBlue() {
    return hexColor('2281e3');
  }
}