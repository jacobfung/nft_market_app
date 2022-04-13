import 'package:flutter/material.dart';
import 'package:nft_market/widget/common_button.dart';

class ReminderPage extends StatelessWidget {
  final String title;
  final String content;
  final String imgUrl;
  final String? btnText;
  final VoidCallback? btnCallback;

  const ReminderPage({ Key? key, required this.title, required this.content,required this.imgUrl, this.btnText, this.btnCallback }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imgUrl, height: 140, width: 140,),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 8),
                    child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Center(child: Text(content),)
                  )
                ],
              ),
              if (btnText != null && btnCallback != null) CommonButton(buttonText: btnText!, callback: btnCallback!),
            ]
          ),
        )
      )
    );
  }
}