import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nft_market/utils/color_util.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({ Key? key }) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> with TickerProviderStateMixin {
  double headerOpacity = 0.0;
  late TabController _tabController;
  String rankCate = 'All Categories';
  String rankChain = 'All Chains';
  
  String activityCate = 'All Categories';
  String activityChain = 'All Chains';

  List<String> cateList = ['All Categories', 'New', 'Art', 'Music', '3D', 'Trading Cards', 'Gaming'];
  List<String> chainsList = ['All Chains', 'Ethereum', 'Solana', 'Polygon'];

  List rankingList = [
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '+23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/mOdl9K3PafTkr7D.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '-23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/J4LvXbF7gHTx8ry.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '-23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/1wn8QF5UgrGPTX9.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '+23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/VEu5eTlStrvaQCP.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '-23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/AK2qSlgpdiLc75j.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '+23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/H3RkvJxe96ZgWzV.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '-23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/AK2qSlgpdiLc75j.png'
    },
    {
      'title': 'tony',
      'author': 'shpre',
      'value': '316,816',
      'riseAndFall': '+23.25%',
      'imgUrl': 'https://s2.loli.net/2022/04/19/J4LvXbF7gHTx8ry.png'
    },
  ];

  List activityList = [
    {
      'title': 'babobuy #001',
      'value': '1.4576',
      'time': 3,
      'imgUrl': 'https://s2.loli.net/2022/04/14/FKfcgWIAEYbnXza.png',
    },
    {
      'title': 'grillis #003',
      'value': '0.4571',
      'time': 8,
      'imgUrl': 'https://s2.loli.net/2022/04/19/puqeKHh5PkvBwYE.png',
    },
    {
      'title': 'Trio Cube #011',
      'value': '0.1575',
      'time': 15,
      'imgUrl': 'https://s2.loli.net/2022/04/19/a2re4LYsd3ihBXu.png',
    },
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(() {
      _onScroll(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(),
          _tapBar(),
          _tabPage()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: ColorUtil.hexColor('e5e5e5').withOpacity(headerOpacity),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, .17).withOpacity(0.2 * headerOpacity),
            offset: const Offset(1.1, 1.1),
            blurRadius: 3
          ),
        ],
      ),
      child: Container(
        height: 30 * (1 - headerOpacity) + 30,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 20, right: 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Statistic', style: TextStyle(fontSize: 11 * (1 - headerOpacity) + 15, fontWeight: FontWeight.w700)),
            GestureDetector(
              onTap: () {
                print('search');
              },
              child: const Icon(Icons.search, size: 30,),
            )
          ],
        ),
      ),
    );
    
  }

  Widget _tapBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: TabBar(
        indicatorWeight: 1,
        controller: _tabController,
        labelPadding: const EdgeInsets.only(top: 13, bottom: 13),
        labelColor: ColorUtil.commonBlue(),
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: ColorUtil.commonBlue(), width: 2,),
        ),
        tabs: const [
          Text('Rankings', style: TextStyle(fontWeight: FontWeight.w700),),
          Text('Activity', style: TextStyle(fontWeight: FontWeight.w700),)
        ]
      ),
    );
    
  }
  // 两个tab对应的页面
  Widget _tabPage() {
    return Flexible(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _switchPage(true),
          _switchPage(false),
        ],
      )
    );
  }

  Widget _switchPage(bool isRank) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          const SizedBox(height: 32,),
          Row(
            children: [
              _filter(isRank ? rankCate : activityCate, isRank, true),
              const SizedBox(width: 10,),
              _filter(isRank ? rankChain : activityChain, isRank, false),
            ],
          ),
          const SizedBox(height: 10,),
          Expanded(child: isRank ? _rankingList() : _activityList(),)
        ],
      ),
    );
    
  }

  Widget _filter(String recentFilter, bool isRank, bool isCate) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          print('click');
          String? result = await _showFilter(recentFilter, isRank, isCate);
          if (result != null) {
            EasyLoading.show();
            Timer(const Duration(milliseconds: 300), (() => EasyLoading.dismiss()));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: ColorUtil.hexColor('e2e8f0'),),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(child: Text(recentFilter),),
              const SizedBox(width: 25,),
              const Icon(Icons.expand_more)
            ],
          ),
        ),
      )
    );
  }

  Future<String?> _showFilter(String recentFilter, bool isRank, bool isCate) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorUtil.hexColor('ffffff'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 8, 24, MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorUtil.hexColor('eaeff3'),
                ),
                transform: Matrix4.translationValues(0, -20, 0),
                width: 48, height: 6,
              ),
              const SizedBox(height: 30,),
              FilterList(
                list: isCate ? cateList : chainsList, 
                seleted: recentFilter,
                callback: (value) {
                  setState(() {
                    if (isRank && isCate) rankCate = value;
                    if (isRank && !isCate) rankChain = value;
                    if (!isRank && isCate) activityCate = value;
                    if (!isRank && !isCate) activityChain = value;
                  });
                },
              )
            ]
          )
        );
      },
    );
  }

  void _onScroll(double pixels) {
    double opacity = 0.0;

    if (pixels >= 40) {
      opacity = headerOpacity;
    } else if (pixels <= 40 && pixels >= 0 && headerOpacity != pixels / 40) {
      opacity = pixels / 40;
    } else if (pixels <= 0 && headerOpacity != 0.0) {
      opacity = 0.0;
    }
    setState(() {
      headerOpacity = opacity;
    });

  }

  Widget _rankingList() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: rankingList.asMap().entries.map((item) {
          int index = item.key;
          return Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorUtil.hexColor('f3f7f9')))
            ),
            child: Row(
              children: [
                Text((index + 1).toString()),
                const SizedBox(width: 14,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    image: NetworkImage(item.value['imgUrl']),
                    placeholder: const AssetImage('assets/images/placeholder.png'),
                    width: 40, height: 40,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.value['title']), 
                      Text('@${item.value['author']}', style: TextStyle(color: ColorUtil.commonGrey(),))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${item.value['value']} ETH', style: const TextStyle(fontWeight: FontWeight.w700),),
                    Text(
                      item.value['riseAndFall'], 
                      style: TextStyle(
                        color: item.value['riseAndFall'].toString().startsWith('-') ? ColorUtil.hexColor('f75555') : ColorUtil.hexColor('22c55e')
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      )
    );
  }

  Widget _activityList() {
    return SingleChildScrollView(
      child: Column(
        children: activityList.asMap().entries.map((item) {
          return Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorUtil.hexColor('f3f7f9')))
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: NetworkImage(item.value['imgUrl']),
                    placeholder: const AssetImage('assets/images/placeholder.png'),
                    width: 56, height: 56,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.value['title']),
                      Text('Sale', style: TextStyle(color: ColorUtil.commonGrey(),))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${item.value['value']}', style: const TextStyle(fontWeight: FontWeight.w700),),
                    Text(
                      '${item.value['time']} min ago', 
                      style: TextStyle(
                        color: ColorUtil.commonGrey()
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
// 构建一个筛选list的有状态widget 以同时更新内外部状态
class FilterList extends StatefulWidget {
  final List<String> list; // 筛选的list
  final String seleted; // 当前已选的筛选条件
  final ValueChanged<String> callback; // 点击筛选的回调
  const FilterList({ Key? key, required this.list, required this.seleted, required this.callback }) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  String? seleted;

  @override
  void initState() {
    super.initState();
    setState(() {
      seleted = widget.seleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list.map((e){
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: GestureDetector(
            onTap: () {
              widget.callback(e);
              setState(() => seleted = e);
              Navigator.of(context).pop(e);
            },
            child: Row(
              children: [
                const Icon(Icons.face),
                const SizedBox(width: 10,),
                Expanded(child: Text(e)),
                if (e == seleted) Icon(Icons.done, color: ColorUtil.commonBlue(),)
              ],
            ),
          )
        );
      }).toList()
    );
  }
}