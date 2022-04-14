
import 'package:flutter/material.dart';
import 'package:nft_market/modal/home_modal.dart';
import 'package:nft_market/pages/home/place_bid.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';

class LiveBiding extends StatefulWidget {
  List<BidingGoods> bidingGoodsList = [];
  LiveBiding({ Key? key, required this.bidingGoodsList }) : super(key: key);

  @override
  _LiveBidingState createState() => _LiveBidingState();
}

class _LiveBidingState extends State<LiveBiding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.hexColor('ffffff'),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          Stack(
            children: [
              const SizedBox(
                height: 40,
                child: Center(child: Text('Live Biding', style: TextStyle(fontWeight: FontWeight.w700),),),
              ),
              Positioned(
                left: 14,
                child: GestureDetector(
                  onTap: () {
                    print('back');
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorUtil.hexColor('eaeff3')),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Icon(Icons.chevron_left)
                  )
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.bidingGoodsList.length,
              padding: const EdgeInsets.fromLTRB(40, 12, 40, 20),
              itemBuilder: (BuildContext context, int index) {
                return _bidingItem(widget.bidingGoodsList[index], index);
              },
            ),
          )
          
        ],
      ),
    );
  }

  Widget _bidingItem(BidingGoods goods, int index) { 
    return Container(
      height: 300,
      width: 300,
      margin: EdgeInsets.only(bottom: 24),
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
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'hero$index',
            child: Image.network(goods.imgPath, width: 300, height: 167,),
          ),
          const SizedBox(height: 11,),
          Text(goods.author, style: TextStyle(color: ColorUtil.commonGrey()),),
          const SizedBox(height: 5,),
          Row(
            children: [
              Expanded(child: Text(goods.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),),
              Image.asset('assets/images/eth_value.png', width: 6, height: 10,),
              Text(' ${goods.value} ETH', style: TextStyle(color: ColorUtil.hexColor('0ab27d')),)
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(34, 129, 227, .15),
                  borderRadius: BorderRadius.circular(19)
                ),
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                child: Text(goods.timesLeft, style: TextStyle(color: ColorUtil.commonBlue()),),
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

}