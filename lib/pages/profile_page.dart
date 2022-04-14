import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/pages/auth/login_page.dart';
import 'package:nft_market/utils/color_util.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            CommonButton(buttonText: 'Log Out', callback: _logOut),
          ],
        )
        
      ),
    );
  }

  void _logOut() async {
    bool? isLogout = await showLogoutDialog();
    print('isLogout $isLogout');
    if (isLogout == true) {
      SpUtil.putBool('isLogin', false);
      NavigatorUtil.pushAndRemoveAll(context, const LoginPage());
    }
  }

  Future<bool?> showLogoutDialog() {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            width: 327,
            height: 188,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text('logout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                const SizedBox(height: 24),
                const Text('Are you sure you want to log out?'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _btn(false),
                    _btn(true)
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _btn(bool isLogout) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(isLogout);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isLogout ? ColorUtil.commonBlue() : const Color.fromRGBO(34, 129, 227, .1)
        ),
        padding: const EdgeInsets.fromLTRB(43, 12, 43, 12),
        child: Text(isLogout ? 'Logout' : 'Cancel', style: TextStyle(color: isLogout ? Colors.white : ColorUtil.commonBlue()),),
      ),
    );
  }
}