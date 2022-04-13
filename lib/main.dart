import 'package:device_info_plus/device_info_plus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nft_market/pages/main_app.dart';
import 'package:nft_market/pages/splash/splash_screen.dart';
import 'package:nft_market/utils/color_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final IosDeviceInfo iosDviceInfo = await deviceInfo.iosInfo;
  final bool _isPhysical = iosDviceInfo.isPhysicalDevice;
  SpUtil.putBool("isPhysical", _isPhysical);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogin = SpUtil.getBool('isLogin')!;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Satoshi',
        backgroundColor: ColorUtil.hexColor('ffffff')
      ),
      home: isLogin ? const MainApp() : const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
