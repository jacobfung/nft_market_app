import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/http/api.dart';
import 'package:nft_market/http/request.dart';
import 'package:nft_market/pages/main_app.dart';
import 'package:nft_market/pages/auth/register_page.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';
import 'package:nft_market/widget/common_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool btnActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 100)),
                CommonInput(
                  title: 'Email',
                  hint: 'Enter your email address',
                  icon: Icons.email,
                  onChanged: (String text) {
                    email = text;
                    checkInput();
                  },
                ),
                CommonInput(
                  title: 'Password',
                  hint: 'Enter your password',
                  isPsw: true,
                  icon: Icons.lock,
                  onChanged: (String text) {
                    password = text;
                    checkInput();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 24, bottom: 16),
                      child: Text('Forget Password?'),
                    )
                  ],
                ),
                CommonButton(buttonText: 'Sign In', callback: _signIn, isActive: btnActive,),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text('Or Sign In With', style: TextStyle(color: ColorUtil.commonGrey()),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _icon('google'),
                    _icon('apple'),
                    _icon('facebook'),
                  ],
                )
              ]
            ),
            Positioned(
              bottom: 10,
              child: Row(
                children: [
                  Text("Dont't have account? "),
                  GestureDetector(
                    onTap: () => NavigatorUtil.push(context, RegisterPage()),
                    child: Text(
                      "Sign Up", 
                      style: TextStyle(color: ColorUtil.commonBlue(), fontWeight: FontWeight.w700),
                    ),
                  )
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _icon(String imgName) {
    return GestureDetector(
      onTap: () {
        print('sign in with $imgName');
      },
      child: Container(
        height: 52,
        width: 52,
        margin: EdgeInsets.only(left: 8, right: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: ColorUtil.hexColor('eaeff3'))
        ),
        child: Image.asset('assets/images/$imgName.png'),
      ),
    );
    
  }

  void checkInput() {
    bool isActive = (email.isEmpty || password.isEmpty) ? false : true;
    setState(() {
      btnActive = isActive;
    });
  }

  void _signIn() async {
    print('email: $email , password: $password');
    if (!btnActive) return;
    final res = await Api.login({'email': email, 'password': password});
    if (res['code'] == 200) NavigatorUtil.push(context, MainApp());
    SpUtil.putBool('isLogin', true);
    print(res);
  }
}

