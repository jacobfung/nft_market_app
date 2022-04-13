import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class ThirdScreen extends StatelessWidget {
  final AnimationController animationController;
  const ThirdScreen({ Key? key, required this.animationController }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _secScreenAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );
    final _imgScreenAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );
    final _textAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      )
    );
    return SlideTransition(
      position: _secScreenAnimation,
      child: SlideTransition(
        position: _imgScreenAnimation,
        child: Column(
          children: [
            SlideTransition(
              position: _imgScreenAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    padding: const EdgeInsetsDirectional.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color.fromRGBO(34, 129, 227, .15)
                    ),
                    child: Image.asset('assets/images/sec_icon.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 45),
                    constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
                    child: Image.asset('assets/images/sec_img.png', fit: BoxFit.contain,)
                  ),
                ],
              ),
            ),
            SlideTransition(
              position: _textAnimation,
              child: Column(
                children: [
                  const Text('Scure Your Assets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                  const Text('with the good one', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    width: 320,
                    child: Text(
                      "NFTX has partnered with some notable companies and recently partnered with Rarible to help secure non-fungible tokens artists' and creators' work.",
                      style: TextStyle(color: ColorUtil.commonGrey()),
                      textAlign: TextAlign.center,
                    ),
                  )
                ]
              ),
            ),
            
          ],
        ),
      )
    );
  }
}