import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/widget/common_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // input controller
  final TextEditingController _searchInputController = TextEditingController();
  // 焦点
  final _focusNode = FocusNode();
  // 搜索关键词
  String? keyword = '';
  // 是否可清空input框
  bool allowClear = false;
  // 关键词搜索历史
  List<String> searchList = SpUtil.getStringList('recentSearchList') ?? [];
  // 是否正在搜索
  bool isSearching = false;
  // 过滤条件list
  static List itemFilterList = ['Assets', 'Bundles'];
  static List statusFilterList = ['Buy Now', 'On Auction', 'New Product', 'Has Offers'];
  static List sortFilterList = ['Recently Created', 'Most Viewed', 'Oldest', 'Low to High', 'High to Low'];
  String itemFilter = 'Assets';
  String statusFilter = 'Buy Now';
  String sortFilter = 'Recently Created';

  static List<Map<String, dynamic>> searchResultList = [
    {
      "img": 'https://s2.loli.net/2022/04/18/dsLVBGHzgCYR18v.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/yZBMmGfoRVpukTd.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/Jf8ohTmqa1tg2cY.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/BTh9tEjmbHWvrqI.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/dsLVBGHzgCYR18v.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/yZBMmGfoRVpukTd.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/Jf8ohTmqa1tg2cY.png'
    },
    {
      "img": 'https://s2.loli.net/2022/04/18/BTh9tEjmbHWvrqI.png'
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
      backgroundColor: ColorUtil.hexColor('ffffff'),
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
              const SizedBox(height: 16,),
              _filterList(0),
              _filterList(1),
              _filterList(2),
              CommonButton(buttonText: 'Apply', callback: () {
                print('筛选条件： item: $itemFilter status: $statusFilter sort: $sortFilter');
                Navigator.pop(context);
                if (isSearching) print('调搜索接口');
              })
            ],
          ),
        );
      }
    );
  }

  Widget searchResult() {
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
        padding: const EdgeInsets.only(top: 20),
        children: imgWidget,
      )
    );
  }

  Widget _filterList(int filterType) {
    String title;
    List filterList;
    switch (filterType) {
      case 0:
        title = 'Item Type';
        filterList = itemFilterList;
        break;
      case 1:
        title = 'Status';
        filterList = statusFilterList;
        break;
      case 2:
        title = 'Sort By';
        filterList = sortFilterList;
        break;
      default:
        title = '';
        filterList = [];
    }
    return FilterList(
      title: title,
      filterList: filterList,
      selectdItem: filterType == 0 ? itemFilter : (filterType == 1 ? statusFilter : sortFilter),
      onchanged: (value) {
        setState(() {
          if (filterType == 0) itemFilter = value;
          if (filterType == 1) statusFilter = value;
          if (filterType == 2) sortFilter = value;
        });
      },
    );
  }
}

class FilterList extends StatefulWidget {
  final String title; // filter标题
  final List filterList; //
  final String selectdItem;
  final ValueChanged<String> onchanged;
  const FilterList({ Key? key, required this.title, required this.filterList, required this.onchanged, required this.selectdItem }) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  String? item;

  @override
  void initState() {
    // 初始化当前选中的筛选条件
    item = widget.selectdItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 8,),
        SizedBox(
          width: 500,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.filterList.asMap().entries.map((element) {
              return GestureDetector(
                onTap: () {
                  widget.onchanged(element.value);
                  setState(() {
                    item = element.value;
                  });
                },
                child: _filterItem(element.value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16,)
      ],
    );
  }

  Widget _filterItem(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: title == item ? ColorUtil.commonBlue() : ColorUtil.hexColor('eaeff3')),
        color: title == item ? const Color.fromRGBO(34, 129, 227, .17) : Colors.white,
      ),
      child: Text(title, style: TextStyle(color: title == item ? ColorUtil.commonBlue() : ColorUtil.commonGrey()),),
    );
  }

}