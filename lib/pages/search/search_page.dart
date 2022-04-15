import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchInputController = TextEditingController();
  final _focusNode = FocusNode();
  String? keyword = '';
  bool allowClear = false;
  List<String> searchList = SpUtil.getStringList('recentSearchList') ?? [];
  bool isSearching = false;

  static List<Map<String, dynamic>> searchResultList = [
    {
      "img": 'https://5fou.com/i/2022/04/15/p0fa19.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0hjlq.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0i2mj.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0i7o9.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0fa19.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0hjlq.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0i2mj.png'
    },
    {
      "img": 'https://5fou.com/i/2022/04/15/p0i7o9.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    searchResult();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) print('当前正获取焦点');
    });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.hexColor('ffffff'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Search', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  GestureDetector(
                    onTap: () {
                      print('open filter');
                      _showBottomSheet();
                    },
                    child: Image.asset('assets/images/filter.png', width: 40, height: 40,),
                  )
                ],
              ),
              const SizedBox(height: 35,),
              _searchInput(),
              const SizedBox(height: 15,),
              if (!isSearching) ..._recentSearchBox()
              else searchResult()
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      height: 52,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorUtil.hexColor('e5e5e5')),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 22, color: ColorUtil.commonGrey(),),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _searchInputController,
              cursorColor: Colors.black,
              onChanged: _onSearchChange,
              onSubmitted: _onSearchSubmit,
              decoration: const InputDecoration(
                hintText: 'Search Items',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15)
              ),
            ),
          ),
          if (allowClear)
          GestureDetector(
            onTap: () {
              _searchInputController.clear();
              setState(() {
                allowClear = false;
                keyword = '';
              });
            },
            child: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  List<Widget> _recentSearchBox() {
    return [
      const Text('Recent Search', style: TextStyle(fontSize: 16),),
      const SizedBox(height: 16,),
      Expanded(
        child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: searchList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _recentSearchItem(searchList[index])
            );
          },
        ),
      )
    ];
  }

  Widget _recentSearchItem(String searchName) {
    Color _grey = ColorUtil.commonGrey();
    return GestureDetector(
      onTap: () {
        print('search $searchName');
        _focusNode.unfocus();
        _searchInputController.text = searchName;
        keyword = searchName;
        _onSearchSubmit(searchName);
        setState(() {
          allowClear = true;
        });
      },
      child: Row(
        children: [
          Icon(Icons.schedule, color: _grey, size: 18,),
          const SizedBox(width: 18,),
          Expanded(
            child: Text(searchName, style: TextStyle(color: _grey)),
          ),
          Icon(Icons.north_west, color: _grey, size: 18,)
        ]
      ),
    );
  }
  
  void _onSearchChange(String value) {
    print(value);
    setState(() {
      allowClear = value.isNotEmpty;
    });
    keyword = value;
  }

  void _onSearchSubmit(String value) {
    List oldSearchList = SpUtil.getStringList('recentSearchList') ?? [];
    print('old $oldSearchList');
    setState(() {
      isSearching = true;
    });
    int repeatIndex = oldSearchList.indexOf(value);
    // 如果输入框没有内容 或者内容在搜索历史第一位 则不进行搜索历史更新
    if (value.isEmpty || repeatIndex == 0) return;
    // 去除重复搜索历史
    if (oldSearchList.contains(value)) oldSearchList.removeAt(repeatIndex);
    
    setState(() {
      searchList = [value, ...oldSearchList];
    });
    SpUtil.putStringList('recentSearchList', searchList);
    print('new $searchList');
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 8, 24, MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Container(
                width: 80, height: 5,
                color: ColorUtil.hexColor('eaeff3'),
              ),
              const SizedBox(height: 16,),
              const Text('Filter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
              const SizedBox(height: 16,)
            ],
          ),
        );
      }
    );
  }

  searchResult() {
    List<Widget> imgWidget = searchResultList.asMap().entries.map((item) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/placeholder.png'),
          image: NetworkImage(item.value['img']),
          fit: BoxFit.cover,
        ),
      );
    }).toList();

    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 40,
          crossAxisSpacing: 30
        ),
        padding: EdgeInsets.only(top: 20),
        children: imgWidget,
      )
    );
    
  }

}