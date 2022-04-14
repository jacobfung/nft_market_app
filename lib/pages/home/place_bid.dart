import 'package:flutter/material.dart';
import 'package:nft_market/modal/home_modal.dart';
import 'package:nft_market/pages/common/reminder_page.dart';
import 'package:nft_market/utils/color_util.dart';
import 'package:nft_market/utils/navigator_util.dart';
import 'package:nft_market/widget/common_button.dart';
import 'package:nft_market/widget/dialog_checkbox.dart';

class PlaceBid extends StatefulWidget {
  final BidingGoods goods;
  final int index;
  const PlaceBid({ Key? key, required this.goods, required this.index }) : super(key: key);

  @override
  _PlaceBidState createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.hexColor('ffffff'),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          _header(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    Hero(
                      tag: 'hero${widget.index}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(widget.goods.bigImgPath, width: 300, height: 300, fit: BoxFit.cover,),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    _infoContainer(),
                    _costBox(false),
                    const SizedBox(height: 42,),
                    _offersList()
                  ]
                ),
              )
            ),
          ),
          CommonButton(buttonText: 'Place Bid', callback: _handleDialog),
          SizedBox(height: 10 + MediaQuery.of(context).padding.bottom,),
        ]
      )
    );
  }

  Widget _header() {
    return Stack(
      children: [
        const SizedBox(
          height: 40,
          child: Center(child: Text('Place Bid', style: TextStyle(fontWeight: FontWeight.w700),),),
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
              child: Icon(Icons.keyboard_backspace)
            )
          ),
        ),
      ],
    );
  }

  Widget _infoContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.goods.title, style: TextStyle(fontWeight: FontWeight.w700),),
        const SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Created by', style: TextStyle(color: ColorUtil.commonGrey()),),
            Text('Ends in', style: TextStyle(color: ColorUtil.commonGrey()),)
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.goods.author, style: TextStyle(color: ColorUtil.commonBlue(), fontWeight: FontWeight.w700)),
            Text(widget.goods.timesLeft)
          ],
        )
      ],
    );
  }

  Widget _costBox(bool isDialog) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border.all(color: ColorUtil.hexColor('f1f5f9')),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          _costBtn(false),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/eth.png', height: 24, width: 24,),
                SizedBox(width: 12,),
                Text('32.06 ETH', style: TextStyle(fontSize: isDialog ? 24 : 12, fontWeight: isDialog ? FontWeight.w700 : FontWeight.w500))
              ],
            ),
          ),
          _costBtn(true),
        ]
      ),
    );
  }

  Widget _costBtn(bool isPlus) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtil.hexColor('f8fafc'),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Icon(isPlus ? Icons.add : Icons.remove)
      ),
    );
  }

  Widget _offersList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Offers', style: TextStyle(
                color: ColorUtil.hexColor('64748b'), 
                fontWeight: FontWeight.w700, 
                fontSize: 18
              ),
            ),
            Text('Last 7 days', style: TextStyle(color: ColorUtil.commonBlue(),))
          ],
        )
      ],
    );
  }

  _handleDialog() async {
    await showBidDialog();
  }

  Future<bool?> showBidDialog() {
    bool _isAgree = false;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            width: 327,
            height: 334,
            padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              children: [
                Text('Place a bid', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                _costBox(true),
                SizedBox(height: 8,),
                Text('Balance: 0.1345 ETH', style: TextStyle(color: ColorUtil.commonGrey()),),
                SizedBox(height: 24,),
                Row(
                  children: [
                    DialogCheckbox(
                      value: _isAgree,
                      activeColor: ColorUtil.hexColor('0ab27d'),
                      side: BorderSide(color: ColorUtil.hexColor('eaeff3')),
                      onChanged: ( value) {
                        _isAgree = value!;
                      },
                    ),
                    Expanded(
                      child: Text('I Agree with Terms and Privacy Polish', softWrap: true,),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                GestureDetector(
                  onTap: () {
                    if (!_isAgree) return;
                    NavigatorUtil.push(context, ReminderPage(
                      btnText: 'View Item',
                      btnCallback: (){
                        Navigator.pop(context);
                      },
                      title: 'Place a bid Success', 
                      content: 'You have successfully bid on the item and it will be on the list', 
                      imgUrl: 'assets/images/created.png'),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(58, 12, 58, 12),
                    decoration: BoxDecoration(
                      color: ColorUtil.commonBlue(),
                      borderRadius: BorderRadius.circular(32)
                    ),
                    child: Text('Place a bid', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}

