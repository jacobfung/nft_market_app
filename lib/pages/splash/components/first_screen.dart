import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class FirstScreen extends StatefulWidget {
  final AnimationController animationController;
  
  const FirstScreen({ Key? key,required this.animationController }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  Widget build(BuildContext context) {

  final _firstScreenAnimation = Tween<Offset>(
    begin: Offset(0, 2.5),
    end: Offset(-2, 2.5)
  ).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ) ,
    )
  );
    return SlideTransition(
      position: _firstScreenAnimation,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            child: const Text(
              'NFTY',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 47
              ),
            ),
          )
        ),
      ),
    );
    
  }
}