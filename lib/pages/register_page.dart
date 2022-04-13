import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nft_market/http/api.dart';
import 'package:nft_market/pages/login_page.dart';
import 'package:nft_market/pages/verification_page.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';
import 'package:nft_market/widget/common_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';
  String rePassword = '';
  bool privacySelected = false;
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
                // name input
                CommonInput(
                  title: 'Name',
                  hint: 'Enter your name',
                  icon: Icons.person,
                  onChanged: (String text) {
                    name = text;
                    checkInput();
                  },
                ),
                // email input
                CommonInput(
                  title: 'Email',
                  hint: 'Enter your email address',
                  icon: Icons.email,
                  onChanged: (String text) {
                    email = text;
                    checkInput();
                  },
                ),
                // pws input
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
                // repsw input
                CommonInput(
                  title: 'Confirm Password',
                  hint: 'Confirm your password',
                  isPsw: true,
                  icon: Icons.lock,
                  onChanged: (String text) {
                    rePassword = text;
                    checkInput();
                  },
                ),
                // privacy checkbox
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Checkbox(
                      value: privacySelected,
                      activeColor: ColorUtil.hexColor('0ab27d'),
                      side: BorderSide(color: ColorUtil.hexColor('eaeff3')),
                      onChanged: (value) {
                        setState(() {
                          privacySelected = value!;
                        });
                      },
                    ),
                    const Text('I Agree with Terms and Privacy Polish')
                  ],
                ),
                CommonButton(buttonText: 'Sign Up', callback: _signUp, isActive: btnActive),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text('Or Sign Up With', style: TextStyle(color: ColorUtil.commonGrey()),),
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
                  Text("Already hava account? "),
                  GestureDetector(
                    onTap: () => NavigatorUtil.push(context, LoginPage()),
                    child: Text(
                      "Sign In", 
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
        print('sign up with $imgName');
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
    bool isActive;
    if (name.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty) {
      isActive = false;
    } else {
      isActive = true;
    }
    setState(() {
      btnActive = isActive;
    });
  }
  void _signUp() async {
    print('name: $name, email: $email, password: $password, rePsw: $rePassword');
    if (!btnActive) return;
    if (password != rePassword) return EasyLoading.showError('the two passwords you entered were inconsistent.');
    if (!privacySelected) return EasyLoading.showError('please agree with Terms and Privacy Polish.');
    var res = await Api.register(name, email, password);
    print('======$res');
    if (res['code'] == 200) NavigatorUtil.push(context, VerificationPage(email: email, otp: res['otp'].toString(),));
  }
}