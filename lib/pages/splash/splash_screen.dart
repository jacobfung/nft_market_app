import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/pages/login_page.dart';
import 'package:nft_market/pages/main_app.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';
import 'package:nft_market/pages/splash/components/first_screen.dart';
import 'package:nft_market/pages/splash/components/forth_screen.dart';
import 'package:nft_market/pages/splash/components/sec_screen.dart';
import 'package:nft_market/pages/splash/components/third_screen.dart';
import 'package:nft_market/utils/color_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.hexColor('FFFFFF'),
      body: SafeArea(
        child: Stack(
          children: [
            FirstScreen(animationController: _animationController!),
            SecScreen(animationController: _animationController!),
            ThirdScreen(animationController: _animationController!),
            ForthScreen(animationController: _animationController!),
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) => AnimatedOpacity(
                opacity: _animationController!.value >= 0.2 &&
                        _animationController!.value <= 0.6
                    ? 1
                    : 0,
                duration: Duration(milliseconds: 200),
                child: _pageSlider(),
              ),
            ),
            _nextButton()
          ],
        ),
      )
    );
  }

  Widget _nextButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16 + MediaQuery.of(context).padding.bottom),
      child: CommonButton(buttonText: 'Next', callback: _onNextClick,)
    );
    
  }

  Widget _pageSlider() {
    int _selectedIndex = 0;

    if (_animationController!.value >= 0.7) {
      _selectedIndex = 3;
    } else if (_animationController!.value >= 0.5) {
      _selectedIndex = 2;
    } else if (_animationController!.value >= 0.3) {
      _selectedIndex = 1;
    } else if (_animationController!.value >= 0.1) {
      _selectedIndex = 0;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 100 + MediaQuery.of(context).padding.bottom),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _selectedIndex == i
                            ? ColorUtil.commonBlue()
                            : ColorUtil.hexColor('eaeff3'),
                      ),
                      width: 32,
                      height: 4,
                    ),
                  )
              ],
            ),
          ],
        ),
      )
      
    );
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value < 0.2) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value >= 0.2 &&
        _animationController!.value < 0.4) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value >= 0.4 &&
        _animationController!.value < 0.6) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value == 0.6) {
      print('push to login');
      bool isLogin = SpUtil.getBool('isLogin')!;
      isLogin ? NavigatorUtil.push(context, MainApp()) : NavigatorUtil.replace(context, LoginPage());
    }
  }
}