import 'package:flutter/material.dart';

class NavigatorUtil {
  // 跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
  // 跳转到指定页面并销毁之前所有路由
  static pushAndRemoveAll(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return page;
    }), (route) => false);
  }
  // 取代当前页面
  static replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
}