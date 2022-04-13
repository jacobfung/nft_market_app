import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nft_market/pages/auth/login_page.dart';
import 'package:nft_market/pages/common/reminder_page.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';
import 'package:nft_market/widget/verification_box.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  final String otp;
  const VerificationPage({ Key? key, required this.email, required this.otp }) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String? _verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              Center(
                child: Column(
                children: [
                  const Padding(padding: const EdgeInsets.only(top: 100)),
                  const Text('OTP Verification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  const Text('Check your email. We’ve sent you the'),
                  Text('Code at ${widget.email}'),
                  _verificationBox(),
                  const Text("Didn’t recieved email? "),
                  Text('Requset again', style: TextStyle(color: ColorUtil.hexColor('2281e8'), fontWeight: FontWeight.w700),)
                ]
                )
              ),
              CommonButton(
                buttonText: 'Confirm',
                callback: () async {
                  print('confirm $_verificationCode');
                  if (_verificationCode != widget.otp) return EasyLoading.showError('wrong');
                  NavigatorUtil.push(
                    context, 
                    ReminderPage(
                      title: 'Account created!', 
                      content: 'Your account had beed created successfully.Please sign in to use your account and enjoy', 
                      imgUrl: 'assets/images/created.png',
                      btnText: 'Confirm',
                      btnCallback: () {
                        NavigatorUtil.pushAndRemoveAll(context, const LoginPage());
                      },
                    )
                  );
                },
              ),
            ],
          ),
        )
        
      )
    );
  }

  Widget _verificationBox() {
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 32),
      height: 48,
      child: VerificationBox(
        count: 4,
        itemWidget: 69,
        borderWidth: 1,
        borderRadius: 12,
        borderColor: ColorUtil.commonBlue(),
        onSubmitted: (value) {
          _verificationCode = value;
          print('$value $_verificationCode ${widget.otp}');
        },
      ),
    );
  }
}