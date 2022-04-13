import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class ForthScreen extends StatelessWidget {
  final AnimationController animationController;
  const ForthScreen({ Key? key, required this.animationController }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _secScreenAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );
    final _imgScreenAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
      .animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      )
    );

  

    return SlideTransition(
      position: _secScreenAnimation,
      child: SlideTransition(
        position: _imgScreenAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 320,
                  margin: EdgeInsets.only(top: 130, bottom: 80),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _icon('metamask', Color.fromRGBO(246, 133, 27, .45))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _icon('trust', Color.fromRGBO(51, 117, 187, .45)),
                          _icon('walletconnect', Color.fromRGBO(59, 153, 252, .45)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _icon('forth_wallet', Color.fromRGBO(121, 39, 255, .45))
                        ],
                      )
                    ],
                  ),
                ),
                const Text('Variety of', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                const Text('ctypotocurrency wallet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  width: 320,
                  child: Text(
                    "Supports more than 150 cryptocurrency wallet. For an introduction to the non-fungible tokens world, NFTX is a great place to start.",
                    style: TextStyle(color: ColorUtil.commonGrey()),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        )
      )
    );
  }

  Widget _icon(String imgName, Color color) {
    return Container(
      height: 72,
      width: 72,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: color
      ),
      child: Image.asset('assets/images/$imgName.png'),
    );
  }
}