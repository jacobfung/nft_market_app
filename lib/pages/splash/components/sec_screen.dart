import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class SecScreen extends StatelessWidget {
  final AnimationController animationController;
  const SecScreen({ Key? key, required this.animationController }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _secScreenAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );
    final _imgScreenAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );
    final _textAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      )
    );
    return SlideTransition(
      position: _secScreenAnimation,
      child: Column(
          children: [
            SlideTransition(
              position: _imgScreenAnimation,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 45),
                    constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
                    child: Image.asset('assets/images/first_img.png', fit: BoxFit.contain,)
                  ),
                ],
              ),
            ),
            SlideTransition(
              position: _textAnimation,
              child: Column(
              children: [
                const Text('The largest digital', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                const Text('marketplace for NFT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  width: 320,
                  child: Text(
                    'The world’s largest digital marketplace for crypto collectibles and non-fungible tokens. Buy, sell, and discover exclusive digital items.',
                    style: TextStyle(color: ColorUtil.commonGrey()),
                    textAlign: TextAlign.center,
                  ),
                )
              ]
            ),
            ),
            
          ],
        ),
    );
  }
}