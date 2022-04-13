import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback callback;
  final bool isActive;

  const CommonButton({ Key? key, required this.buttonText, required this.callback, this.isActive = true }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              callback();
            },
            child: Container(
              decoration: BoxDecoration(
                color: isActive ? ColorUtil.commonBlue() : ColorUtil.hexColor('deecfb'),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.fromLTRB(145, 15, 145, 15),
              child: Text(
                buttonText, 
                style: TextStyle(
                  color: ColorUtil.hexColor('ffffff'),
                  fontWeight: FontWeight.w700,
                  fontSize: 14
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}