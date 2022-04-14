import 'package:flutter/material.dart';
import 'package:nft_market/http/api.dart';
import 'package:nft_market/modal/home_modal.dart';
import 'package:nft_market/pages/home/live_biding.dart';
import 'package:nft_market/pages/home/place_bid.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BidingGoods> bidingGoodsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _getBidingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.hexColor('ffffff'),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          _header(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _category(),
                  _liveBiding(),
                  _collections(),
                ]
              ) 
            )
          ),
        ],
      )
      
    );
  }

  Widget _header() {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset('assets/images/eth.png', width: 34, height: 34,),
                const SizedBox(width: 8,),
                const Text('32.06 ETH', style: TextStyle(fontWeight: FontWeight.w700),)
              ],
            ),
          ),
          Image.asset('assets/images/notification.png', height: 25, width: 22,)
        ],
      )
    );
  }

  Widget _category() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.categoryList.length,
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        itemBuilder: (BuildContext context, int index) {
          return _catagoryItem(Category.categoryList[index]);
        },
      ),
    );
  }

  Widget _catagoryItem(Category category) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: category.bgColor,
      ),
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Image.asset(category.imgPath, width: 16, height: 16,),
          const SizedBox(width: 8,),
          Text(category.title, style: const TextStyle(fontWeight: FontWeight.w700), )
        ],
      )
    );
  }

  Widget _liveBiding() {
    return Column(
      children: [
        // live biding title
        Row(
          children: [
            const SizedBox(width: 27,),
            const Expanded(
              child: Text('Live Biding', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            ),
            GestureDetector(
              onTap: () {
                print('see all');
                NavigatorUtil.push(context, LiveBiding(bidingGoodsList: bidingGoodsList,));
              },
              child: Text('See all', style: TextStyle(color: ColorUtil.commonGrey()),),
            ),
            const SizedBox(width: 24,),
          ],
        ),
        // biding listview
        _bidingList()
      ],
    );
  }

  Widget _bidingList() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bidingGoodsList.length,
        padding: const EdgeInsets.fromLTRB(25, 12, 25, 20),
        itemBuilder: (BuildContext context, int index) {
          return _bidingItem(bidingGoodsList[index], index);
        },
      ),
    );
  }

  Widget _bidingItem(BidingGoods goods, int index) { 
    return Container(
      height: 245,
      width: 236,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor('ffffff'),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, .05),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0
        )]
      ),
      margin: const EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'hero$index',
            child: Image.network(goods.imgPath, width: 236, height: 130,),
          ),
          Text(goods.author, style: TextStyle(color: ColorUtil.commonGrey()),),
          Row(
            children: [
              Expanded(child: Text(goods.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),),
              Image.asset('assets/images/eth_value.png', width: 6, height: 10,),
              Text(' ${goods.value} ETH', style: TextStyle(color: ColorUtil.hexColor('0ab27d')),)
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(34, 129, 227, .15),
                  borderRadius: BorderRadius.circular(19)
                ),
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                child: Text('${goods.timesLeft} Left', style: TextStyle(color: ColorUtil.commonBlue()),),
              ),
              GestureDetector(
                onTap: () {
                  NavigatorUtil.push(context, PlaceBid(goods: goods, index:index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorUtil.commonBlue(),
                    borderRadius: BorderRadius.circular(19)
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                  child: const Text('Place a bid', style: TextStyle(color: Colors.white)),
                ),
              )
              
            ],
          )
        ],
      ),
    );
  }

  Widget _collections() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 27,),
            const Expanded(
              child: Text('Top Collections', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            ),
            GestureDetector(
              onTap: () {
                print('View all');
              },
              child: Text('View all', style: TextStyle(color: ColorUtil.commonGrey()),),
            ),
            const SizedBox(width: 24,),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemCount: Collections.bidingGoodsList.length,
          padding: const EdgeInsets.fromLTRB(25, 12, 25, 20),
          itemBuilder: (BuildContext context, int index) {
            return _collectionItem(Collections.bidingGoodsList[index], index);
          },
        ),
        
      ],
    );
  }

  Widget _collectionItem(Collections collection, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          _avatar(collection, index),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(collection.title, style: TextStyle(fontWeight: FontWeight.w700),),
                Text(collection.author, style: TextStyle(color: ColorUtil.commonGrey()),),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/eth_black.png', width: 10, height: 16,),
                  SizedBox(width: 6,),
                  Text(collection.value)
                ],
              ),
              Text(
                collection.riseAndFall, 
                style: TextStyle(color: collection.riseAndFall.startsWith('-') ? ColorUtil.hexColor('f75555') : ColorUtil.hexColor('22c55e')),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _avatar(Collections collection, int index) {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(collection.imgPath)
            )
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11)
            ),
            child: Center(child: Text('${index + 1}')),
          ),
        )
        
      ],
    );
  }

  void _getBidingList() async {
    try {
      var res = await Api.getBidingList();
      if (res['code'] != 200) return;
      var result = BidingGoodsModel.fromJson(res['result']);
      setState(() {
        bidingGoodsList = result.bidingList ?? [];
      });
    } catch (e) {
      print('错误 $e');
    }
  }
}

