import 'package:flutter/material.dart';
import 'package:nft_market/pages/home/home_page.dart';
import 'package:nft_market/pages/profile_page.dart';
import 'package:nft_market/pages/search/search_page.dart';
import 'package:nft_market/pages/statistic_page.dart';
import 'package:nft_market/utils/color_util.dart';

class MainApp extends StatefulWidget {
  const MainApp({ Key? key }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _defaultColor = ColorUtil.commonGrey();
  final _activeColor = ColorUtil.commonBlue();
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          HomePage(), 
          SearchPage(), 
          StatisticPage(), 
          ProfilePage()
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          backgroundColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          backgroundColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem('Home', Icons.home),
            _bottomItem('Search', Icons.search),
            _bottomItem('Statistic', Icons.assessment),
            _bottomItem('Profile', Icons.person)
          ]
        ),
      )
      
    );
  }

  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor,),
      activeIcon: Icon(icon, color: _activeColor,),
      label: title
    );
  }
}