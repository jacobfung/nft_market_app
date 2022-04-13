import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/pages/login_page.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonButton(buttonText: 'Log Out', callback: _logOut),
      ),
    );
  }

  void _logOut() {
    SpUtil.putBool('isLogin', false);
    NavigatorUtil.pushAndRemoveAll(context, const LoginPage());
  }
}